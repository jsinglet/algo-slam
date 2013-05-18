package algoslam

import org.apache.commons.codec.digest.DigestUtils

class AlgoHelpersTagLib {


    def challengesDropdown = {attrs ->


        def c = Challenge.findAll()

        out << """\
           <select name="challenge">
        """

        c.each {


                if (attrs?.selected == it.name) {
                    out << """\
                   <option value="${it.name}" selected>${it.name}</option>
                """
                } else {
                    out << """\
                   <option value="${it.name}">${it.name}</option>
                """

                }
            }



        out << """\
           </select>
        """

    }


    def gravitar = { attrs ->

        def encoded = DigestUtils.md5Hex(attrs?.email.toLowerCase())

        out << "http://www.gravatar.com/avatar/${encoded}?s=${attrs.size}"

    }

    def secondsAgo = {attrs ->

        def then = attrs.date

        def now = new Date()

        int seconds = (now.getTime() - then.getTime()) / 1000L

        def timeString

        if (seconds == 0) {
            timeString = "less than a second ago"
        } else if (seconds < 60) {
            timeString = "${seconds} seconds ago"
        } else if (seconds < (60 * 60)) {
            timeString = "${(int) (seconds / 60)} minutes ago"
        } else if (seconds < (60 * 60 * 24)) {
            timeString = "${(int) (seconds / 60 / 60)} hours ago"
        } else {
            timeString = "${(int) (seconds / 60 / 60 / 24)} days ago"
        }

        out << timeString


    }


}
