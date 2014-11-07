# == Schema Information
#
# Table name: games
#
#  id                             :integer          not null, primary key
#  title                          :string(255)      not null
#  subtitle                       :string(255)
#  source                         :string(255)      not null
#  time_limit                     :integer          not null
#  author_id                      :integer          not null
#  created_at                     :datetime
#  updated_at                     :datetime
#  image_file_name                :string(255)
#  image_content_type             :string(255)
#  image_file_size                :integer
#  image_updated_at               :datetime
#  rounds_count                   :integer          default(0)
#  answers_count                  :integer          default(0)
#  completed_rounds_count         :integer          default(0)
#  completed_answer_matches_count :integer          default(0)
#

require 'uri'

class Game < ActiveRecord::Base
  validates_presence_of :title, :source, :time_limit, :author
  validates_uniqueness_of :title
  validates_format_of :source, with: %r{\b(([\w-]+://?|www[.])[^\s()]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))} # thanks, Jon Gruber!
  validates_numericality_of :time_limit,
    only_integer: true,
    greater_than_or_equal_to: 60,
    less_than_or_equal_to: 900
  before_save :ensure_url_scheme

  scope :with_answers, -> do
    includes(:answers).where.not(game_answers: {game_id: nil});
  end

  belongs_to :author, counter_cache: :created_games_count,
    class_name: "User",
    inverse_of: :created_games

  has_many :answers, class_name: "GameAnswer"
  has_many :rounds, inverse_of: :game

  has_many :completed_rounds,
    -> { where(is_completed: true) },
    class_name: "Round"

  has_many :completed_answer_matches,
    through: :completed_rounds,
    source: :answer_matches

  has_attached_file :image,
    styles: {show: "600x600>", thumb: "100x100#"},
    default_url: "https://s3-us-west-2.amazonaws.com/dorkle-production/" +
                 "images/:style/default_game.jpg"
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def get_subtitle
    self.subtitle && !self.subtitle.empty? ? self.subtitle : "(no subtitle)"
  end

  def get_source_host
    URI(self.source).host[0, 25]
  end

  def play_count
    self.completed_rounds_count
  end

  def playthrough_rate
    self.play_count.to_f / self.rounds_count
  end

  def average_score
    correct_count = self.completed_answer_matches_count
    potential_count = self.play_count * self.answers_count
    correct_count.to_f / potential_count
  end

  def update_custom_counter_caches
    self.completed_rounds_count = self.completed_rounds.count
    self.completed_answer_matches_count = self.completed_answer_matches.count
  end

  private
  def ensure_url_scheme
    self.source = "http://#{self.source}" unless self.source.include?("://")
  end
end
