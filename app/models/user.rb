require 'byebug'
class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many(:boards,
        class_name: "Board",
        foreign_key: :user_id,
        primary_key: :id
        )

  def User.find_by_credentials(username, password)
    user = User.find_by(username: username[1])
    # byebug
    if user && user.is_password?(password[1])
      user
    else
      nil
    end
  end

  def User.generate_password_digest(password)
    BCrypt::Password.create(password)
  end

  def User.generate_session_token
    SecureRandom::urlsafe_base64
  end

  attr_reader :password

  def is_password?(password)
    BCrypt::Password.new(password_digest) == password
  end

  def password=(password)
    @password = password
    self.password_digest = User.generate_password_digest(password)
  end
end
