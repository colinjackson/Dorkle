# == Schema Information
#
# Table name: game_answers
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  answer     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  regex      :string(255)
#

class GameAnswer < ActiveRecord::Base
  validates_presence_of :game, :answer
  validates_uniqueness_of :answer, case_sensitive: false, scope: :game_id

  belongs_to :game, inverse_of: :answers
  has_many :matches,
    class_name: "RoundAnswerMatch",
    foreign_key: :answer_id,
    inverse_of: :answer

  def get_regex
    self.regex ? self.regex : self.answer.downcase
  end

  def matches?(guess)
    !!(guess =~ /\A\s*(#{self.get_regex})\s*\Z/)
  end

end
