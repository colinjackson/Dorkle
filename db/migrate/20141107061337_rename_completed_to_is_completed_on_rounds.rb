class RenameCompletedToIsCompletedOnRounds < ActiveRecord::Migration
  def change
    rename_column :rounds, :completed, :is_completed
  end
end
