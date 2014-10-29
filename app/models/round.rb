class Round < ActiveRecord::Base
  validates_presence_of :game

  belongs_to :game, inverse_of: :rounds
  belongs_to :player, class_name: "User", inverse_of: :rounds
  has_many :answers, through: :game, source: :answers
  has_many :answer_matches, class_name: "RoundAnswerMatch", inverse_of: :round
end
