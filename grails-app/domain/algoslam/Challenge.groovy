package algoslam

class Challenge {

    static hasMany = [submissions: Submission]

    String name
    String description
    Date open
    Date close
    //SortedSet submissions
    String testCaseFileName
    String testCase
    String testCaseSolution



    static mapping = {
        submissions lazy: true
        testCase type: 'text'
        testCaseSolution type: 'text'


    }

    static constraints = {
        name(blank: false)
        description(blank: false)
        open(blank: false)
        close(blank: false)
    }
}
