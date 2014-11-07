class AddRoundAndMatchCounterCachesToGames < ActiveRecord::Migration
  def change
    add_column :games, :rounds_count, :integer, default: 0
    add_column :games, :answers_count, :integer, default: 0
    add_column :games, :completed_rounds_count, :integer, default: 0
    add_column :games, :completed_answer_matches_count, :integer, default: 0

    Game.all.find_each do |game|
      Game.reset_counters(game, :rounds, :answers)
      game.completed_rounds_count = game.rounds.completed.size
      game.completed_answer_matches_count = game.completed_answer_matches.size

      game.save
    end
  end
end
