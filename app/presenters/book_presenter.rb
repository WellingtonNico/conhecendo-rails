class BookPresenter < SimpleDelegator

    def image
        return '' unless super
        helpers.image_tag(super.to_s).html_safe
    end

    def text
        "<br/>#{super.gsub(/\n/,"<br/>")}".html_safe
    end

    def value
        "R$ #{super}"
    end

    def person
        super.name
    end

    private
        def helpers
            ApplicationController.helpers
        end

end