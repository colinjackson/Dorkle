class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :source, null: false
      t.integer :time_limit, null: false
      t.integer :author_id, null: false

      t.timestamps
    end

    add_index :games, :author_id
    add_index :games, :title, unique: true
  end
end
