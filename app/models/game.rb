# == Schema Information
#
# Table name: games
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  subtitle           :string(255)
#  source             :string(255)      not null
#  time_limit         :integer          not null
#  author_id          :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Game < ActiveRecord::Base
  validates_presence_of :title, :source, :time_limit, :author
  validates_uniqueness_of :title
  validates_format_of :source, with: %r{\b(([\w-]+://?|www[.])[^\s()]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))} # thanks, Jon Gruber!
  validates_numericality_of :time_limit,
    only_integer: true,
    greater_than_or_equal_to: 60,
    less_than_or_equal_to: 900
  belongs_to :author, class_name: "User", inverse_of: :created_games
  has_many :answers, class_name: "GameAnswer"
  has_many :rounds, inverse_of: :game

  has_attached_file :image,
    styles: {show: "600x600>", thumb: "100x100#"},
    default_url: "https://s3.amazonaws.com/dorkle-development/images/defaults/game.jpg"

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def getSubtitle
    self.subtitle ? self.subtitle : "(no subtitle)"
  end
end
