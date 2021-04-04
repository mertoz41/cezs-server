class CreateBandposts < ActiveRecord::Migration[6.1]
  def change
    create_table :bandposts do |t|
      t.integer :band_id
      t.integer :song_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
