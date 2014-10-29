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
end
