class CreateBandgenres < ActiveRecord::Migration[6.1]
  def change
    create_table :bandgenres do |t|
      t.integer :band_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
