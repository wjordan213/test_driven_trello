class User < ActiveRecord::Base
  def User.generate_password_digest(password)
    BCrypt::Password.create(password)
  end

  def User.generate_session_token
    SecureRandom::urlsafe_base64
  end

  attr_reader :password

  def password=(password)
    self.password_digest = User.generate_password_digest(password)
  end
end
