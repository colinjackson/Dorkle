class GameAnswer < ActiveRecord::Base
  validates_presence_of :game, :answer
  validates_uniqueness_of :answer, case_sensitive: false, scope: :game_id

  belongs_to :game, inverse_of: :answers
  has_many :matches,
    class_name: "RoundAnswerMatch",
    foreign_key: :answer_id,
    inverse_of: :answer
end
