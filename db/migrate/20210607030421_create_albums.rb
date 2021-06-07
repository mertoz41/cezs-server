class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :artist_id
      t.string :spotify_id

      t.timestamps
    end
  end
end
