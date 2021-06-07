class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :artist_name
  def artist_name
    return object.artist.name
  end
end
