class BandpostshareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :artist_id, :song_name, :artist_name, :bandname, :band_picture
  def clip
    bandpost = object.bandpost
    return url_for(bandpost.clip)
  end
  def artist_id
    bandpost = object.bandpost
    return bandpost.artist.id
  end

  def song_name
    bandpost = object.bandpost
    return bandpost.song.name
  end 

  def artist_name
    bandpost = object.bandpost
    return bandpost.artist.name
  end 

  def band_picture
    bandpost = object.bandpost
    return url_for(bandpost.band.picture)
  end
  def bandname
    bandpost = object.bandpost
    return bandpost.band.name
  end



end
