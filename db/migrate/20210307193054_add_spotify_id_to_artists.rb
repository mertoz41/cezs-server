class AddSpotifyIdToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :spotify_id, :string
  end
end
