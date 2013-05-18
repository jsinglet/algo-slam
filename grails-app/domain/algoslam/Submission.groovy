package algoslam

class Submission implements Comparable {


    String email
    String pid
    String name
    Date created = new Date()
    boolean graded = false
    boolean compiled = false
    boolean passedCases = false
    boolean ranCorrectly = false
    long avgRuntime = 0
    long avgMemoryUsed = 0

    String program

    static belongsTo = [challenge: Challenge]



    static mapping = {
        program type: 'text'
    }


    static constraints = {
    }


    def beforeInsert() {
        created = new Date()
    }

    def didFail = {

        return (compiled == false || passedCases == false || ranCorrectly == false)

    }

    int compareTo(Object t) {

        def a= this
        def b = t;

        //special comparison
        if (a.didFail() || b.didFail()) {
            if (a.didFail() && b.didFail() == false)
                return 1 //a is further down the list
            else if (a.didFail() == false && b.didFail())
                return -1; //a is higher up on the list
            else
                return a.id.compareTo(b.id);
        } else {

            def c = a.avgRuntime.compareTo(b.avgRuntime)

            if(c==0)
                c = a.avgMemoryUsed.compareTo(b.avgMemoryUsed)

            if(c==0)
                return a.id.compareTo(b.id)

            return c;
        }
    }
}
