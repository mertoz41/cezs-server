class AddEventtimeToBandevents < ActiveRecord::Migration[6.1]
  def change
    add_column :bandevents, :event_time, :string
  end
end
