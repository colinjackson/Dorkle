class CreateGameAnswers < ActiveRecord::Migration
  def change
    create_table :game_answers do |t|
      t.references :game, null: false, index: true
      t.string :answer, null: false

      t.timestamps
    end

    add_index :game_answers, [:game_id, :answer], unique: true
  end
end
