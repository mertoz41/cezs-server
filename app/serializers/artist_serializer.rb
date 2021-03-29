class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :avatar, :influence_count, :song_count
  def influence_count
    return object.users.length
  end
  def song_count
    return object.songs.length
  end
end
