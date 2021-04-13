class AddEventdateToUserevents < ActiveRecord::Migration[6.1]
  def change
    add_column :userevents, :event_date, :string
  end
end
