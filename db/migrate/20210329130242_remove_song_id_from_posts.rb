class RemoveSongIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :song_id, :string
  end
end
