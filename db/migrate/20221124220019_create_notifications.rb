class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :action_user_id
      t.boolean :seen
      t.integer :applaud_id
      t.integer :comment_id
      t.integer :event_id

      t.timestamps
    end
  end
end
