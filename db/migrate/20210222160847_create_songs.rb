class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :artist_id

      t.timestamps
    end
  end
end
