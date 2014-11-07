class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :notifiable, polymorphic: true
      t.integer :event_id
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
