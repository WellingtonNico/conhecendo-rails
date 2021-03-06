class Person < ApplicationRecord
    include ImageSaver
    has_secure_password
    validates :name, presence: true, length: {maximum: 50}
    validates :email, allow_blank: true, allow_nil: true, uniqueness: true,email: {allow_blank: true}
    validates :born_at, presence: true
    validate :age_limit
    before_save :convert_email
    validates :password, presence:{on: :create},length:{minimum:8,allow_blank: true}
    has_many :books, dependent: :destroy
    has_many :categories, -> { distinct }, through: :books
    has_one :image, dependent: :destroy, as: :imageable
    has_many :orders, dependent: :destroy
    has_many :order_items, through: :orders

    # escopos
    scope :admins, -> {where(admin:true)}
    scope :by_domain, -> (domain) { where("email like ?", "%@#{domain}") }
    default_scope -> { order(:name) }

    # recebe um email e senha e retorna uma pessoa caso a autenticação suceder
    # caso contrário retorna nulo
    def self.auth(email,password)
        person = Person.where(email: email).first
        person && person.authenticate(password) ? person : nil
    end

    private 
        def age_limit
            if self.born_at.nil? || Date.current.year - self.born_at.year < 16
                errors.add(:born_at,'tem que ser maior de 16 anos')
                throw(:abort)
            end
        end

        def convert_email
            email.downcase!
        end

end
