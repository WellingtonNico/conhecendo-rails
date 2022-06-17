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

    def image
        return '' unless super
        helpers.image_tag(super.to_s).html_safe
    end

    private
        def helpers
            ApplicationController.helpers
        end


end
