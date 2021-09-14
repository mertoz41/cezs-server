class RemovePostIdFromFollowNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :follow_notifications, :post_id, :integer
  end
end
