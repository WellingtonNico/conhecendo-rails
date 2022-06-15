class PersonPresenter
    attr_reader :person
    delegate :id, :name, :email, to: :person

    def initialize(person)
        @person = person
    end

    def admin
        @person.admin ? 'sim' : 'não'
    end

    def born_at
        helpers.l(@person.born_at)
    end

    def password
        '*' * 10
    end

    private
    
    def helpers
        ApplicationController.helpers
    end



end
