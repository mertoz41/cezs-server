class AddEventdateToBandevents < ActiveRecord::Migration[6.1]
  def change
    add_column :bandevents, :event_date, :datetime
  end
end
