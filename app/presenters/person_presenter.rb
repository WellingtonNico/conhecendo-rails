class PersonPresenter < SimpleDelegator

    def admin
        super ? 'sim' : 'não'
    end

    def born_at
        helpers.l(super)
    end

    def password
        '*' * 10
    end

    private
    
    def helpers
        ApplicationController.helpers
    end

end
