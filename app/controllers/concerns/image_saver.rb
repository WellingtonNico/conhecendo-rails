module ImageSaver
    extend ActiveSupport::Concern

    included do
        after_action :save_image, only: %i[ create update ]
    end

    private
        def save_image
            data_stream = params[:data_stream]
            return unless data_stream.present?
            save(image,data_stream)
        end

        def image
            model_object_name = controller_name.singularize
            modelObject = instance_variable_get("@#{model_object_name}")
            img = modelObject.image
            return img if img
            Image.new(
                title: model_object_name,
                imageable_id: modelObject.id,
                imageable_type: model_object_name.camelize
            )
        end

        def save(image,data_stream)
            image = image
            image.data_stream = data_stream
            image.height = 200
            image.save
        end

end