class BookPresenter < SimpleDelegator

    def image
        return '' unless super
        helpers.image_tag(super.to_s).html_safe
    end

    def value
        "R$ #{super}"
    end

    private
        def helpers
            ApplicationController.helpers
        end

end