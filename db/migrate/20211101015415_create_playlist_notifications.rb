class CreatePlaylistNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_notifications do |t|
      t.integer :action_user_id
      t.integer :user_id
      t.integer :playlist_id
      t.boolean :seen

      t.timestamps
    end
  end
end
