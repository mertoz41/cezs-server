class AddSongIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :song_id, :integer
  end
end
