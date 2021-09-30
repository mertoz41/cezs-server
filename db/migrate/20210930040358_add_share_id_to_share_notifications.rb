class AddShareIdToShareNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :share_notifications, :share_id, :integer
  end
end
