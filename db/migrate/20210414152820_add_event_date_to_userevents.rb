class AddEventDateToUserevents < ActiveRecord::Migration[6.1]
  def change
    add_column :userevents, :event_date, :datetime
  end
end
