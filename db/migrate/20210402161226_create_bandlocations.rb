class CreateBandlocations < ActiveRecord::Migration[6.1]
  def change
    create_table :bandlocations do |t|
      t.integer :band_id
      t.integer :location_id

      t.timestamps
    end
  end
end
