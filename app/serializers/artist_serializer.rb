class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :influence_count, :song_count, :favoriteuser_count
  has_many :bandposts
  has_many :posts
  has_many :followingusers
  has_many :songs
  
  def influence_count
    return object.users.size
  end
  def song_count
    return object.songs.size
  end
  def favoriteuser_count
    return object.favoriteusers.size
  end
  
end
