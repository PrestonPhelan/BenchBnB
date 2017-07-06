class User < ApplicationRecord
  # Attribute Readers/Writers/Accessors
  attr_reader :password

  # Validations
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # Relations

  # Methods
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.password_is?(password) ? user : nil
  end

  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
