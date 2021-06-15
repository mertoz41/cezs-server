class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :song_id, :artist_id, :clip, :created_at, :username, :artist_name, :song_name, :useravatar, :comment_count, :share_count, :thumbnail, :genre_id, :genre, :instruments, :featuredusers

  def clip
    url_for(object.clip)
  end
  def thumbnail
    url_for(object.thumbnail)
  end

  def instruments
    object.instruments.map do |instrument|
      InstrumentSerializer.new(instrument)
    end
  end
  def featuredusers
    object.featuredusers.map do |user|
      UserSerializer.new(user)
    end
  end

  
  def genre
    return object.genre.name
  end
  def comment_count
    return object.comments.size
  end
  def share_count
    return object.shares.size
  end

  # def created_at
  #   object.created_at.to_date
  # end

  def username
    user = User.find(object.user_id)
    return user.username
  end
  def useravatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
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
