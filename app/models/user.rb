# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#
class User < ApplicationRecord
    include Commentable

    attr_reader :password
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :password_digest, presence: { 
        message: "^Password cannot be blank"
     }
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :session_token, presence: true

    after_initialize :ensure_session_token

    has_many(
        :goals,
        class_name: "Goal",
        foreign_key: :creator_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(
        :written_comments,
        class_name: "Comment",
        foreign_key: :user_id,
        primary_key: :id,
        dependent: :destroy
    )

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        
        user.is_password?(password) ? user : nil
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    private

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end
end
