class Round < ActiveRecord::Base
  validates_presence_of :game

  belongs_to :player, class_name: "User", inverse_of: :rounds
  belongs_to :game, inverse_of: :rounds
  has_many :answers, through: :game, source: :answers
  has_many :answer_matches, class_name: "RoundAnswerMatch", inverse_of: :round

  def handle_guess(guess)
    answer = answer_for_guess(guess)
    if answer
      self.answer_matches.create!(answer: answer)
    else
      return false
    end
  end

  def answer_for_guess(guess)
    self.answers
      .joins("LEFT OUTER JOIN (#{RoundAnswerMatch.where(round_id: self.id).to_sql})
              AS matches ON matches.answer_id = game_answers.id")
      .where(answer: guess)
      .where('matches.id IS NULL')
      .first
  end

  def answers_left
    self.answers
      .joins("LEFT OUTER JOIN (#{RoundAnswerMatch.where(round_id: self.id).to_sql})
              AS matches ON matches.answer_id = game_answers.id")
      .where('matches.id IS NULL')
      .count
  end

  def time_remaining
    self.game.time_limit - (Time.now - self.created_at)
  end

  # SAVE the SQL version for reference/posterity:
  #
  # def answer_for_guess(guess)
  #   self.answers.find_by_sql(<<-SQL).first
  #   SELECT
  #     answers.*
  #   FROM
  #     game_answers AS answers
  #   INNER JOIN
  #     games
  #   AS games ON answers.game_id = games.id
  #   LEFT OUTER JOIN (
  #     SELECT
  #       round_answer_matches.*
  #     FROM
  #       round_answer_matches
  #     WHERE
  #       round_answer_matches.round_id = #{self.id}
  #   ) AS matches ON matches.answer_id = answers.id
  #   WHERE
  #     answers.answer = '#{guess}' AND
  #     matches.id IS NULL
  #   SQL
  # end

end
