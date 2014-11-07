# == Schema Information
#
# Table name: round_answer_matches
#
#  id         :integer          not null, primary key
#  round_id   :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class RoundAnswerMatch < ActiveRecord::Base
  validates_presence_of :round, :answer
  validates_uniqueness_of :answer, scope: :round

  after_update :update_counter_caches

  belongs_to :round, inverse_of: :answer_matches
  has_one :game, through: :round
  belongs_to :answer, class_name: "GameAnswer", inverse_of: :matches

  private
  def update_counter_caches
    self.game.completed_rounds_count = self.game.rounds.completed.size
  end
end
