class Image < ApplicationRecord
    after_save :update_file
    after_destroy :delete_file
    # imageable é o nome virtual do modelo para associação da imagem
    # veja no model person que ele "exporta" a associação com a imagem com 
    # o mesmo nome de associação
    belongs_to :imageable, polymorphic: true


    attr_accessor :data_stream, :width, :height
    
    def file_name
        "#{id}.jpg"
    end

    def path
        "/images/#{imageable_type.pluralize.underscore}/"
    end

    def to_s
        "#{path}#{file_name}"
    end
    
    def full_path
        "#{Rails.root}/public/#{to_s}"
    end

    
    private
        def update_file
            return false if data_stream.blank?
            
            data = data_stream.read
            return false if data.empty?
            
            delete_file
            check_path
            write_data(data)
            resize
        end
    
        def delete_file
            File.unlink(full_path) if File.exist?(full_path)
        end

        def check_path
            # checa se a pasta existe e cria no caso de não existir
            dir = File.expand_path(File.dirname(full_path))
            FileUtils.mkpath(dir) unless Dir.exist?(dir)
        end

        def write_data(data)
            File.open(full_path,'wb') do |file|
                file.write(data)
            end
            check_size
        end

        def check_size
            File.size(full_path)>0
        end

        def resize
            return unless @width || @height
            image = MiniMagick::Image.new(full_path)
            image.resize "#{@width}x#{@height}"
        end
end
