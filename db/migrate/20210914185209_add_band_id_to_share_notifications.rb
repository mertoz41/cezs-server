class AddBandIdToShareNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :share_notifications, :band_id, :integer
  end
end
