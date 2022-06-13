class EmailValidator < ActiveModel::EachValidator
    EXPRESSION = /\A[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}\z/

    def validate_each(record,attr,value)
        return true if value.blank? && (options[:allow_blank] || false) || value.match?(EXPRESSION)
        record.errors[:email]<< (options[:message] || 'deve ser um email válido')
    end
end
