class AddBandIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :band_id, :integer
  end
end
