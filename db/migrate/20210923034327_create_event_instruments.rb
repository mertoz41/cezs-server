class CreateEventInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :event_instruments do |t|
      t.integer :instrument_id
      t.integer :event_id

      t.timestamps
    end
  end
end
