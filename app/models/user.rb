class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :username, :email
  validates_format_of :email, with: /\A[^\;\*\+\/\\]+@.+\..+\z/
  validates :password, length: { minimum: 6, allow_nil: true }

  def self.find_by_credentials(credentials)
    user = self.find_by_username(credentials[:username])
    user && user.is_password?(credentials[:password]) ? user : nil
  end

  def password=(password)
    return if password.empty?
    
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
  attr_reader :password
end
