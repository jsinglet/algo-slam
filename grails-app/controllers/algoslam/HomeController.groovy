package algoslam

import org.apache.commons.codec.digest.DigestUtils
import org.apache.commons.validator.EmailValidator

class HomeController {


    def rules = {}

    def messages = [
            "Prove You are Better than Everyone Else.",
            "My Algorithm Can Beat Up Your Algorithm.",
            "Nice For Loop You Got There.",
            "Is that O(n) or O(n^2)?",
            "As a Great Man Once Said: \"I Am Better Than You.\"",
            "To Slam or Not to Slam. That is the Question.",
            "Your Runtime Matters Bigtime."
    ]


    def doLogin = {

        def u = Admin.findByEmail(params?.login)

        if (u && u.password.equalsIgnoreCase(DigestUtils.md5Hex(params?.password))) {
            session.isAdmin = "YES"
            redirect(controller: "challenge")
        } else {
            flash.error = "Invalid username or password";
            redirect(action: "login")
        }


    }

    def login = {
    }



    def index = {

        Random r = new Random();

        [taunt: messages[r.nextInt(messages.size())]]
    }


    def viewSource = {


        def s = Submission.find("from Submission s where s.id=?", Long.parseLong(params?.s))

        //make sure it's past the due date.

        if (s.challenge.close.getTime() < new Date().getTime()) {
            render(template: 'sourceCodeForm', model: ['source': s.program])
        } else {
            render(template: 'sourceCodeFormError')
        }


    }

    def test = {

        def challengeClose = Challenge.executeQuery("select close from Challenge c where id=?", Long.parseLong(params?.ajaxIn))


        def rawSubmissions = Submission.executeQuery("select id, passedCases, pid, graded, avgRuntime, avgMemoryUsed, ranCorrectly, created, email, compiled, name from Submission s where id IN (select max(id) from Submission s2 where challenge_id=? and graded=true group by pid)", Long.parseLong(params?.ajaxIn))

        //remap to objects.
        def submissions = []

        rawSubmissions.each {s ->
            def sub = [:]
            //map all the params we care about
            sub.id = s[0]
            sub.passedCases = s[1]
            sub.pid = s[2]
            sub.graded = s[3]
            sub.avgRuntime = s[4]
            sub.avgMemoryUsed = s[5]
            sub.ranCorrectly = s[6]
            sub.created = s[7]
            sub.email = s[8]
            sub.compiled = s[9]
            sub.name = s[10]

            submissions.add(sub)
        }


        submissions.sort {a, b ->

            //special comparison
            if (didFail(a) || didFail(b)) {
                if (didFail(a) && didFail(b) == false)
                    return 1 //a is further down the list
                else if (didFail(a) == false && didFail(b))
                    return -1; //a is higher up on the list
                else
                    return a.id.compareTo(b.id);
            } else {

                def c = a.avgRuntime.compareTo(b.avgRuntime)

                if (c == 0)
                    c = a.avgMemoryUsed.compareTo(b.avgMemoryUsed)

                if (c == 0)
                    return a.id.compareTo(b.id)

                return c;
            }
        }



        [a: '']
    }

    def about = {}


    def challengeTab = {
        if (params?.ajaxIn) {

            def challengeId = params?.ajaxIn

            if(challengeId instanceof String)
                challengeId = Long.parseLong(params?.ajaxIn)

            def challengeClose = Challenge.executeQuery("select close from Challenge c where id=?", challengeId)

            def rawSubmissions = Submission.executeQuery("select id, passedCases, pid, graded, avgRuntime, avgMemoryUsed, ranCorrectly, created, email, compiled, name from Submission s where id IN (select max(id) from Submission s2 where challenge_id=? and graded=true group by pid)", challengeId)

            //remap to objects.
            def submissions = []

            rawSubmissions.each {s ->
                def sub = [:]
                //map all the params we care about
                sub.id = s[0]
                sub.passedCases = s[1]
                sub.pid = s[2]
                sub.graded = s[3]
                sub.avgRuntime = s[4]
                sub.avgMemoryUsed = s[5]
                sub.ranCorrectly = s[6]
                sub.created = s[7]
                sub.email = s[8]
                sub.compiled = s[9]
                sub.name = s[10]

                submissions.add(sub)
            }


            submissions.sort {a, b ->

                //special comparison
                if (didFail(a) || didFail(b)) {
                    if (didFail(a) && didFail(b) == false)
                        return 1 //a is further down the list
                    else if (didFail(a) == false && didFail(b))
                        return -1; //a is higher up on the list
                    else
                        return a.id.compareTo(b.id);
                } else {

                    def c = a.avgRuntime.compareTo(b.avgRuntime)

                    if (c == 0)
                        c = a.avgMemoryUsed.compareTo(b.avgMemoryUsed)

                    if (c == 0)
                        return a.id.compareTo(b.id)

                    return c;
                }
            }


            render(template: 'challengeTab', model: [challengeClose: challengeClose[0], submissions: submissions])

            return
        }

    }

    def rankings = {

        /*if(params?.ajaxIn){
            def challenge = Challenge.find("from Challenge c where c.id=?", Long.parseLong(params?.ajaxIn))
            render(template: 'challengeTab', model: [challenge: challenge])
            return
        }*/

        def challenges = Challenge.findAll()
        [challenges: challenges]

    }


    private boolean didFail(what) {
        return (what.compiled == false || what.passedCases == false || what.ranCorrectly == false)

    }

    def queue = {


        def toRun = Submission.findAll("from Submission s where s.graded=false order by id asc")
        def didRun = Submission.findAll("from Submission s where s.graded=true order by id desc LIMIT 50")


        if (params?.ajaxIn) {
            render(template: params?.ajaxIn, model: [toRun: toRun, didRun: didRun])
            return
        }

        [toRun: toRun, didRun: didRun]
    }


    def upload = {
        flash.error = null;
    }

    def doUpload = {

        def programText
        flash.error = null;

        //validation
        if (!params?.program || !params?.email || !params?.pid || !params?.challenge || !params?.name || params?.name.length() < 5) {
            flash.error = "Please fill out all fields."
        } else if (params?.agree != "Y") {
            flash.error = "You must agree to these terms to upload."
        } else if (!EmailValidator.getInstance().isValid(params?.email)) {
            flash.error = "Please enter a valid email address."
        } else {
            //attempt to validate the program.

            programText = params?.program.getFileItem().getString();

            //if you write a 100k program, you need your head examined.
            if (programText.length() > 255 && programText.length() < 100000) {
                def tmpFile = File.createTempFile("program-upload", ".c")

                params?.program.transferTo(tmpFile)

                //try and syntax check this fucker.
                def cmd = """gcc -fsyntax-only ${tmpFile.absolutePath}"""
                def p = cmd.execute()
                p.waitForOrKill(5000)

                //make sure it doesn't contain any evil calls. examples:
                def evilStuff = ["system", "fork", "execl", "execle", "execlp", "execv", "execvp", "execvP", "popen", "sys/types.h", "sys/socket.h", "netinet/in.h", "netdb.h"]

                def wasEvil = evilStuff.find {
                    programText.contains(it)
                }

                if (wasEvil || p.exitValue() != 0) {
                    flash.error = "Invalid C Program uploaded. Please try again."
                }


            } else {
                flash.error = "Invalid program file. Please select a valid one."
            }

            //validate the name/email/pid -- we key off of pid. So if

            def submissions = Submission.findAllByPid(params?.pid.toUpperCase())
            def submissionsByEmail = Submission.findAllByEmail(params?.email)

            if (submissions.size() > 0) {
                submissions.each {
                    System.out.println(it.name)
                    if (!it.name?.equalsIgnoreCase(params?.name) || !it.email?.equalsIgnoreCase(params?.email)) {
                        flash.error = "Invalid PID/Email/Name combo. Previous combination used was: ${it.name} and ${it.email} (hint: use these)"
                    }
                }
            }
            //now check to make sure the email address they used is on pairty. That is, make sure they aren't using an email address mapped to a different pid.
            if(!flash.error){
                if(submissions.size() != submissionsByEmail.size()){
                    flash.error = "The email address you entered is already being used by a different PID. Please enter the correct PID or enter a new email address."
                }
            }

        }


        def challenge = Challenge.findByName(params?.challenge)

        if (challenge.close.getTime() < new Date().getTime()) {
            flash.error = "Challenge is closed."
        }

        //validation is the pits.
        if (!flash.error) {
            //try to create it.
            try {

                def submission = new Submission()

                submission.pid = params?.pid.toUpperCase()
                submission.email = params?.email.toLowerCase()
                submission.program = programText
                submission.name = params?.name
                //submission.save()

                challenge.addToSubmissions(submission)
                challenge.save(flush: true, failOnError: true)


                render(template: 'uploadSuccess')

            } catch (Exception e) {
                e.printStackTrace();
                flash.error = "There was an error processing your request. Please try again."
                render(template: 'uploadForm', model: [pid: params?.pid, challenge: params?.challenge, email: params?.email, name: params?.name])
            }

        } else {
            render(template: 'uploadForm', model: [pid: params?.pid, challenge: params?.challenge, email: params?.email, name: params?.name])
        }


    }

    def uploadSuccess = {}


    def updateRankings = {

        def challenges = Challenge.findAll()
        def numChallenges = challenges.size()

        //find all unique people (as determined by pid)


        render 'OK'
    }


}
