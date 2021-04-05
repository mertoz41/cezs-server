class BandpostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :band_id, :song_id, :artist_id, :clip, :created_at, :bandname, :artist_name, :song_name
  def clip
    url_for(object.clip)
  end
  def created_at
    object.created_at.to_date
  end
  def bandname
    band = Band.find(object.band_id)
    return band.name
  end
  def artist_name
    artist = Artist.find(object.artist_id)
    return artist.name
  end 

  def song_name
    song = Song.find(object.song_id)
    return song.name
  end 
end