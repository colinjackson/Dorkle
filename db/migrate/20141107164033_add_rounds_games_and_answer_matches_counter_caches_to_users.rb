class AddRoundsGamesAndAnswerMatchesCounterCachesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rounds_count, :integer, default: 0
    add_column :users, :completed_rounds_count, :integer, default: 0
    add_column :users, :completed_answer_matches_count, :integer, default: 0
    add_column :users, :created_games_count, :integer, default: 0

    User.find_each do |user|
      User.reset_counters(user, :rounds, :created_games)
      user.completed_rounds_count = user.rounds.completed.count
      user.completed_answer_matches_count = user.completed_answer_matches.count

      user.save
    end
  end
end
