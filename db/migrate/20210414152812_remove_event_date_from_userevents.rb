class RemoveEventDateFromUserevents < ActiveRecord::Migration[6.1]
  def change
    remove_column :userevents, :event_date, :string
  end
end
