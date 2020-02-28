class EmailValidator < ActiveModel::EachValidator
    def validate_each(record,attribute, value)
        unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            record.errors[attribute] << (options[:message] || "is not an email")
        end
    end
end

#Email Regex can be added in 2 ways
#1. Email validator + email: true
#2. VALID_EMAIL_REGEX + format: {with: VALID_EMAIL_REGEX}

class User < ApplicationRecord
    validates :username,  presence: true, 
                length: { minimum: 3, maximum:25 }, 
                uniqueness: { case_sensitive: false }
    #VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :email, presence: true, 
                uniqueness: { case_sensitive: false },
                email: true
                #format: {with: VALID_EMAIL_REGEX}

end

