class RemoveArtistIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :artist_id, :string
  end
end
