class AddCreatedGamesCompletedRoundsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :created_games_completed_rounds_count, :integer,
      default: 0

    User.find_each do |user|
      user.created_games_completed_rounds_count =
        user.created_games_completed_rounds.count

      user.save
    end
  end
end
