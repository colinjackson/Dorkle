class AddRegexToGameAnswers < ActiveRecord::Migration
  def change
    add_column :game_answers, :regex, :string
  end
end
