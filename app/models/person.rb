class Person < ApplicationRecord
    has_secure_password
    has_secure_token
    validates :name, presence: true, length: {maximum: 50}
    validates :email, allow_blank: true, allow_nil: true, uniqueness: true,email: {allow_blank: true}
    validates :born_at, presence: true
    validate :age_limit
    before_save :convert_email
    validates :password, presence:{on: :create},length:{minimum:8,allow_blank: true}

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
