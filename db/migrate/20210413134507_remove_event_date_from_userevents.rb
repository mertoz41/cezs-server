class RemoveEventDateFromUserevents < ActiveRecord::Migration[6.1]
  def change
    remove_column :userevents, :event_date, :datetime
  end
end
