# == Schema Information
#
# Table name: rounds
#
#  id           :integer          not null, primary key
#  game_id      :integer          not null
#  player_id    :integer
#  is_completed :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#  start_time   :datetime
#

class Round < ActiveRecord::Base
  validates_presence_of :game

  after_update :update_counter_caches

  scope :completed, -> { where(is_completed: true) }

  belongs_to :player, class_name: "User", inverse_of: :rounds
  belongs_to :game, inverse_of: :rounds, counter_cache: true
  has_many :answers, through: :game, source: :answers
  has_many :answer_matches, class_name: "RoundAnswerMatch", inverse_of: :round
  has_many :notifications, as: :notifiable

  def handle_guess(guess)
    answers = answers_for_guess(guess)
    if !answers.empty?
      answers.each { |answer| self.answer_matches.create!(answer: answer) }
    else
      return false
    end
  end

  def answers_for_guess(guess)
    potential_answers = self.answers
      .joins("LEFT OUTER JOIN (#{RoundAnswerMatch.where(round_id: self.id).to_sql})
              AS matches ON matches.answer_id = game_answers.id")
      .where('matches.id IS NULL')

    potential_answers.select do |answer|
      answer.matches?(guess)
    end
  end

  def answers_left
    self.answers
      .joins("LEFT OUTER JOIN (#{RoundAnswerMatch.where(round_id: self.id).to_sql})
              AS matches ON matches.answer_id = game_answers.id")
      .where('matches.id IS NULL')
      .count
  end

  def time_remaining
    return self.game.time_limit if !self.start_time
    self.game.time_limit - (Time.now - self.start_time)
  end

  def percent_right
    ((self.answers_left.to_f * 100 / self.answers.count) + 0.5).to_i
  end

  private
  def update_counter_caches
    return if !self.is_completed
    self.game.completed_rounds_count = self.game.rounds.completed.size
  end

end
