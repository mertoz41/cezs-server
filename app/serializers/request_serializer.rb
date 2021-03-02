class RequestSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :song_name, :song_artist, :fulfilled, :user_id, :user_name, :user_avatar, :created_at, :response_count

  def song_name
    song = Song.find(object.song_id)
    return song.name
  end 

  def song_artist
    artist = Artist.find(object.artist_id)
    return artist.name
  end 
  def user_name
    user = User.find(object.user_id)
    return user.username
  end 
  def created_at
    object.created_at.to_date
  end
  def user_avatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
  def response_count
    object.responses.length
  end
end
