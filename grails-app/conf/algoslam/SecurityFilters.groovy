package algoslam

class SecurityFilters {

    def filters = {
        adminResources(controller: '(submission|challenge)', action: '*') {
            before = {
              if (session?.isAdmin != "YES") {
                redirect(controller:"home")
                return false
              }

              return true
            }

        }
    }

}
