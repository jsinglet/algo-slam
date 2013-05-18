package algoslam


class QueueJob {
    def concurrent = false
    def mailService

    static triggers = { simple name: 'everyMinuteRunner', startDelay: 0, repeatInterval: 60000}

    def execute() {

        log.info("Running Submission Queue")


        def submissions = Submission.findAll("from Submission s where s.graded=false order by s.id asc")

        log.info("Running submission queue")

        for (Submission s: submissions) {

            log.info("Running Submission ${s.id} for Challenge ${s.challenge.name}")

            log.info("Create tmp directory")
            //create the execution directory.
            File tmpDir = new File("/tmp/${UUID.randomUUID().toString()}")
            tmpDir.mkdir();
            log.info("Created as ${tmpDir.absolutePath}")


            log.info("Installing source code to prog.c")
            //copy the source code in.
            File program = new File(tmpDir, "prog.c");
            program.write(s.program)

            //copy the test case
            def challenge = s.challenge

            log.info("Copying challenge file ${challenge.testCaseFileName}")
            File testCase = new File(tmpDir, challenge.testCaseFileName)
            testCase.write(challenge.testCase)

            log.info("Compiling...")
            //compile the program -- allow 5 seconds for it to work
            def cmd = """gcc -o ${tmpDir.absolutePath}/prog ${program.absolutePath}"""
            def p = cmd.execute()
            p.waitForOrKill(5000)
            log.info("Done.")

            //can't even compile it
            if (p.exitValue() != 0) {
                log.info("Compilation did not exit with exit code 0")
                s.graded = true
                s.compiled = false
                s.avgMemoryUsed = 0
                s.avgRuntime = 0
                s.save()
                return
            } else {
                log.info("Compilication worked. Moving on.")
                //run the program, for a max of 30 mins, 3 times. Take the average.
                def runs = []
                def memory = []
                def fail = false;

                log.info("Moving time executable into source directory.")
                """cp /usr/local/bin/time ${tmpDir.absolutePath}""".execute()

                def lastRunOutput

                for (run in 1..3) {
                    try {


                        log.info("Executing run ${run} with: /usr/local/bin/time --verbose ./prog (cwd=${tmpDir.absolutePath})")

                        //run the program -- we wait at most 20 minutes

                        def thisRun = """sudo -u slam ./time --verbose ./prog """
                        def thisProcess = thisRun.execute(null, new File(tmpDir.absolutePath))
                        def stdout = new StringBuffer()
                        def stderr = new StringBuffer()

                        thisProcess.consumeProcessOutput(stdout, stderr)
                        thisProcess.waitForOrKill(1000 * 60 * 20)

                        if (thisProcess.exitValue() != 0) {
                            fail = true;
                            log.info("Process exit value was bad.")
                            break;
                        }


                        for (String out in stderr.toString().split("\n")) {

                            log.info("Time Output: ${out} ")

                            if (out.trim().startsWith("Maximum resident set size (kbytes):")) {
                                memory.add(out.split(":")[1].trim().toInteger())
                            }
                            if (out.trim().startsWith("User time (seconds):")) {
                                runs.add(out.split(":")[1].trim().toDouble())
                            }
                        }
                        log.info("This Run: Memory=${memory.get(memory.size() - 1)}, Time=${runs.get(runs.size() - 1)}")

                        lastRunOutput = stdout.toString()

                    } catch (Exception e) {
                        e.printStackTrace();
                        fail = true;
                        break;
                    }


                }



                //did we get a clean set of runs?
                if (fail || lastRunOutput==null) {

                    log.info("Something failed during running the program.")
                    s.graded = true
                    s.compiled = true
                    s.ranCorrectly = false
                    s.passedCases = false
                    s.avgMemoryUsed = 0
                    s.avgRuntime = 0
                    s.save()
                    return;
                }

                //reformat stuff
                lastRunOutput = lastRunOutput.replaceAll("\n", "").replaceAll(" ", "")
                def controlOutput = challenge.testCaseSolution.replaceAll("\r\n", "").replaceAll("\n", "").replaceAll(" ", "")

                //does the output match?
                if (controlOutput.equals(lastRunOutput) == false) {
                    log.info("Cases don't match.")
                    s.graded = true
                    s.compiled = true
                    s.ranCorrectly = true
                    s.passedCases = false
                    s.avgMemoryUsed = 0
                    s.avgRuntime = 0
                    s.save()
                    return
                }

                //yay - record result
                s.graded = true
                s.compiled = true
                s.ranCorrectly = true
                s.passedCases = true
                s.avgMemoryUsed = memory.sum() / 3
                s.avgRuntime = (runs.sum() / 3) * 1000L; //runtime in ms

                s.save()


            }


        }


    }
}
