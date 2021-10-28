class CreatePlaylistPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_posts do |t|
      t.integer :post_id
      t.integer :playlist_id

      t.timestamps
    end
  end
end
