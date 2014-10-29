class RoundAnswerMatch < ActiveRecord::Base
  validates_presence_of :round, :answer
  validates_uniqueness_of :answer, scope: :round

  belongs_to :round, inverse_of: :answer_matches
  belongs_to :answer, class_name: "GameAnswer", inverse_of: :matches
end
