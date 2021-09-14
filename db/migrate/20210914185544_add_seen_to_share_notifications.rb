class AddSeenToShareNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :share_notifications, :seen, :boolean
  end
end
