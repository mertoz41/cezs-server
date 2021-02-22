class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :genre_id
      t.integer :instrument_id
      t.string :song_id
      t.string :artist_id

      t.timestamps
    end
  end
end
