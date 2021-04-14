class AddEventtimeToUserevents < ActiveRecord::Migration[6.1]
  def change
    add_column :userevents, :event_time, :string
  end
end
