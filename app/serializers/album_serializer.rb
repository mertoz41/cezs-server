class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :artist_name, :artist_id
  def artist_name
    return object.artist.name
  end
 
  
end
