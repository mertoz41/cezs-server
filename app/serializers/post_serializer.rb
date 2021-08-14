class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user_id, :clip, :created_at, :comment_count, :share_count, :thumbnail, :genre_id, :genre, :instruments, :featuredusers, :view_count, :description
  attribute :user_id, if: -> {object.user.present?}
  attribute :username, if: -> {object.user.present?}
  attribute :useravatar, if: -> {object.user.present?}
  attribute :band_id, if: -> {object.band.present?}
  attribute :bandname, if: -> {object.band.present?}
  attribute :bandpicture, if: -> {object.band.present?}
  attribute :current_state, if: -> {object.user.present?}
  attribute :artist_id, if: -> {object.artist.present?}
  attribute :song_id, if: -> {object.song.present?}
  attribute :artist_name, if: -> {object.artist.present?}
  attribute :song_name, if: -> {object.song.present?}
  def clip
    url_for(object.clip)
  end
  def thumbnail
    url_for(object.thumbnail)
  end

  def instruments
    object.instruments.map do |instrument|
      instrument.id
    end
  end
  def featuredusers
    object.featuredusers.map do |user|
      {username: user.username, id: user.id, avatar: url_for(user.avatar)}
    end
  end
  def view_count
    object.postviews.size
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
  def current_state
    user = object.user
    return user.location.city.split()[1]
  end

  def bandname
    band = Band.find(object.band_id)
    return band.name
  end

  def bandpicture
    band = Band.find(object.band_id)
    return url_for(band.picture)
  end



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
