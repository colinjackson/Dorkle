class GameAnswer < ActiveRecord::Base
  validates_presence_of :game, :answer
  validates_uniqueness_of :answer, case_sensitive: false, scope: :game_id

  belongs_to :game, inverse_of: :answers
end
