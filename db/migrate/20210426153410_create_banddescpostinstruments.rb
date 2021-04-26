class CreateBanddescpostinstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :banddescpostinstruments do |t|
      t.integer :banddescpost_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
