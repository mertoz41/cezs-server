class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :genre_id, :instrument_id, :song_id, :artist_id, :clip, :created_at, :user_name, :artist_name, :song_name, :genre_name, :instrument_name 

  def clip
    url_for(object.clip)
  end

  def created_at
    object.created_at.to_date
  end

  def user_name
    user = User.find(object.user_id)
    return user.username
  end

  def artist_name
    artist = Artist.find(object.artist_id)
    return artist.name
  end 

  def song_name
    song = Song.find(object.song_id)
    return song.name
  end 

  def genre_name
    genre = Genre.find(object.genre_id)
    return genre.name 
  end 
  def instrument_name
    instrument = Instrument.find(object.instrument_id)
    return instrument.name 
  end 

end
