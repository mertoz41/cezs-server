class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name
  def artist_name
    return object.artist.name
  end
end
