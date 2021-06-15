class CreateUserdescpostinstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :userdescpostinstruments do |t|
      t.integer :userdescpost_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
