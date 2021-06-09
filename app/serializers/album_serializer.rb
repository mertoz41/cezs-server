class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :artist_name, :artist_id, :favoriteuser_count
  has_many :songs
  def artist_name
    return object.artist.name
  end
  def favoriteuser_count
    return object.favoriteusers.size
  end
 
  
end
