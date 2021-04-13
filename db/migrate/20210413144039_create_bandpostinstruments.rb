class CreateBandpostinstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :bandpostinstruments do |t|
      t.integer :bandpost_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
