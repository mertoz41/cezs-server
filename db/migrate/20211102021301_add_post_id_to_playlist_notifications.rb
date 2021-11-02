class AddPostIdToPlaylistNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :playlist_notifications, :post_id, :integer
  end
end
