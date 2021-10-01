class RemoveBandFromEventNotification < ActiveRecord::Migration[6.1]
  def change
    remove_column :event_notifications, :band_id, :integer
  end
end
