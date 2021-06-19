class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :artist_name, :artist_id, :favoriteuser_count, :post_count, :artistSpotifyId
  has_many :songs
  def artist_name
    return object.artist.name
  end
  def favoriteuser_count
    return object.favoriteusers.size
  end
  def post_count
    return object.posts.size + object.bandposts.size
  end
  def artistSpotifyId
    return object.artist.spotify_id
  end

 
  
end
