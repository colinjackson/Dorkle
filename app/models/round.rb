class Round < ActiveRecord::Base
  validates_presence_of :game, :player

  belongs_to :game, inverse_of: :rounds
  belongs_to :player, class_name: "User", inverse_of: :rounds
  has_many :answers, through: :game, source: :answers
end
