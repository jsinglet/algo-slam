package algoslam

class Ranking {

    String email
    String pid
    String name
    int entered
    int won
    int lost
    int delta
    int rating
    Date lastUpdated = new Date()


    static constraints = {
    }


    def beforeUpdate() {
        lastUpdated = new Date()
    }

}
