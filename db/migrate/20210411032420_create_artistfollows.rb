class CreateArtistfollows < ActiveRecord::Migration[6.1]
  def change
    create_table :artistfollows do |t|
      t.integer :artist_id
      t.integer :user_id

      t.timestamps
    end
  end
end
