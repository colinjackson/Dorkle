class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :game, null: false, index: true
      t.integer :player_id, null: false
      t.boolean :completed, default: false

      t.timestamps
    end

    add_index :rounds, :player_id
  end
end
