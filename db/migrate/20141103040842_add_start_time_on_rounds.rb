class AddStartTimeOnRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :start_time, :datetime
  end
end
