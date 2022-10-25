# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :email, presence: true, unique: true
    validates :session_token, presence: true, unique: true
    validates :password_digset, presence: true
    valdiates :password, length { minimum: 8 }, allow_nil: true

    before_validation: :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(email, password)
       email = Email.find_by(email: email)

        if email && user.is_password?(password)
            email
        else
            nil
        end
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def self.generate_seesion_token
        SecureRandom::urlsafe_base64
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end
end
