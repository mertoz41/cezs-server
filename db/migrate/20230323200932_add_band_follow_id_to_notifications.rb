class AddBandFollowIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :bandfollow_id, :integer
  end
end
