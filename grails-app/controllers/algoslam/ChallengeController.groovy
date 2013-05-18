package algoslam

class ChallengeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [challengeInstanceList: Challenge.list(params), challengeInstanceTotal: Challenge.count()]
    }

    def create = {
        def challengeInstance = new Challenge()
        challengeInstance.properties = params
        return [challengeInstance: challengeInstance]
    }

    def save = {
        def challengeInstance = new Challenge(params)
        if (challengeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'challenge.label', default: 'Challenge'), challengeInstance.id])}"
            redirect(action: "show", id: challengeInstance.id)
        }
        else {
            render(view: "create", model: [challengeInstance: challengeInstance])
        }
    }

    def show = {
        def challengeInstance = Challenge.get(params.id)
        if (!challengeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'challenge.label', default: 'Challenge'), params.id])}"
            redirect(action: "list")
        }
        else {
            [challengeInstance: challengeInstance]
        }
    }

    def edit = {
        def challengeInstance = Challenge.get(params.id)
        if (!challengeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'challenge.label', default: 'Challenge'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [challengeInstance: challengeInstance]
        }
    }

    def update = {
        def challengeInstance = Challenge.get(params.id)
        if (challengeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (challengeInstance.version > version) {
                    
                    challengeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'challenge.label', default: 'Challenge')] as Object[], "Another user has updated this Challenge while you were editing")
                    render(view: "edit", model: [challengeInstance: challengeInstance])
                    return
                }
            }
            challengeInstance.properties = params
            if (!challengeInstance.hasErrors() && challengeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'challenge.label', default: 'Challenge'), challengeInstance.id])}"
                redirect(action: "show", id: challengeInstance.id)
            }
            else {
                render(view: "edit", model: [challengeInstance: challengeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'challenge.label', default: 'Challenge'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def challengeInstance = Challenge.get(params.id)
        if (challengeInstance) {
            try {
                challengeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'challenge.label', default: 'Challenge'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'challenge.label', default: 'Challenge'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'challenge.label', default: 'Challenge'), params.id])}"
            redirect(action: "list")
        }
    }
}
