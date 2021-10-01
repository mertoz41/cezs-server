class RemoveBandFromShareNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :share_notifications, :band_id, :integer
  end
end
