class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name, :user_count, :spotify_id, :album_name, :favoriteusers_count, :artist_id, :artistSpotifyId, :followingusers_count
  has_many :posts, each_serializer: ShortPostSerializer
  # has_many :bandposts
  
  def artist_name
    return object.artist.name
  end

  def artistSpotifyId
    return object.artist.spotify_id
  end

  def user_count
    return object.users.size
  end

  def album_name
    return object.album.name
  end

  def favoriteusers_count
    return object.favoriteusers.size
  end

  def followingusers_count
    return object.followingusers.size
  end

end

