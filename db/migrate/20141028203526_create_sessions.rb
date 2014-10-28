class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, null: false, index: true
      t.string :session_token, null: false

      t.timestamps
    end

    add_index :sessions, :session_token, unique: true
  end
end
