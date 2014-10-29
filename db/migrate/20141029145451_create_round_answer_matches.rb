class CreateRoundAnswerMatches < ActiveRecord::Migration
  def change
    create_table :round_answer_matches do |t|
      t.integer :round_id, null: false
      t.integer :answer_id, null: false

      t.timestamps
    end

    add_index :round_answer_matches, :round_id
    add_index :round_answer_matches, :answer_id
    add_index :round_answer_matches, [:round_id, :answer_id], unique: true
  end
end
