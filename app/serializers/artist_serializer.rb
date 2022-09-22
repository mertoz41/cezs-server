class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :song_count, :favoriteusers_count, :followingusers_count
  has_many :posts, serializer: ShortPostSerializer
  has_many :albums
  
  def song_count
    return object.songs.size
  end
  def favoriteusers_count
    return object.favoriteusers.size
  end
  def followingusers_count
    return object.followingusers.size
  end

  
end
