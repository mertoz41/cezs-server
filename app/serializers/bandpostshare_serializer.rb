class BandpostshareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :artist_id, :song_name, :artist_name, :bandname, :bandpicture, :created_at, :share_count, :band_id
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

  def bandpicture
    bandpost = object.bandpost
    return url_for(bandpost.band.picture)
  end
  def bandname
    bandpost = object.bandpost
    return bandpost.band.name
  end
  def created_at
    bandpost = object.bandpost
    return bandpost.created_at
  end
  def share_count
    bandpost = object.bandpost
    return bandpost.bandpostshares.size
  end
  def band_id
    bandpost = object.bandpost
    return bandpost.band.id
  end






end
