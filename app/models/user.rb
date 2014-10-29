class User < ActiveRecord::Base

  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :username, :email
  validates_format_of :email, with: /\A[^\;\*\+\/\\]+@.+\..+\z/
  validates :password, length: { minimum: 6, allow_nil: true }

  before_create :set_default_name

  has_many :sessions

  def self.find_by_credentials(credentials)
    user = self.find_by_username(credentials[:username])
    user.try(:is_password?, credentials[:password]) ? user : nil
  end

  def password=(password)
    return if !password || password.empty?

    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ==(other)
    return other.is_a?(User) && other.id == self.id
  end

  private
  attr_reader :password

  def set_default_name
    self.name ||= "Dork Dorkly"
  end

end
