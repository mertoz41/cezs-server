class AddActionBandToEventNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :event_notifications, :action_band_id, :integer
  end
end
