# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  username           :string(255)      not null
#  email              :string(255)      not null
#  name               :string(255)
#  password_digest    :string(255)      not null
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'uri'

class User < ActiveRecord::Base

  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :username, :email
  validates_format_of :email, with: /\A[^\;\*\+\/\\]+@.+\..+\z/
  validates :password, length: { minimum: 6, allow_nil: true }

  before_create :set_default_name

  has_many :sessions, inverse_of: :user
  has_many :rounds, foreign_key: :player_id, inverse_of: :player
  has_many :created_games,
    class_name: "Game",
    foreign_key: :author_id,
    inverse_of: :author

  has_attached_file :image,
    styles: {show: "600x600>", thumb: "50x50#"},
    default_url: "https://s3-us-west-2.amazonaws.com/" +
                 "dorkle-production/images/:style/dorkle-face.jpg"
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

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

  def getName
    self.name ? self.name : self.username
  end

  private
  attr_reader :password

  def set_default_name
    self.name ||= "Dork Dorkly"
  end

end
