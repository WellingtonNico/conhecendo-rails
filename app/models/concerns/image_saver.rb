module ImageSaver
    attr_accessor :data_stream
    attr_writer :image_title

    def self.included(base)
        base.after_save :save_image
    end

    def image_title
        @image_title || (image.present? && image.title.present? ? image.title : '')
    end

    private
    def save_image
        return unless data_stream.present?
        configure_image(find_image).save
    end

    def find_image
        return image if image
        Image.new(imageable_id: id, imageable_type: self.class.to_s)
    end

    def configure_image(image)
        image.title = image_title
        image.data_stream = data_stream
        image.height = 200
        image
    end
end