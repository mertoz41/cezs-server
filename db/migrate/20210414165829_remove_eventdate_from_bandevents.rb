class RemoveEventdateFromBandevents < ActiveRecord::Migration[6.1]
  def change
    remove_column :bandevents, :event_date, :string
  end
end
