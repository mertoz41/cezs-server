class ShareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :band_id, :post_id, :bandpicture, :user_id, :clip, :song_name, :useravatar, :artist_name, :username, :share_count, :comment_count, :artist_id, :created_at, :thumbnail, :songSpotifyId, :featuredusers, :view_count

  def clip
    post = object.post
    return url_for(post.clip)
  end

  def view_count
    post = object.post
    return post.postviews.size
  end

  def artist_id
    post = object.post
    if post.artist
      return post.artist.id
    end
  end

  def song_name
    post = object.post
    if post.song
      return post.song.name
    end
  end 
  def featuredusers
    post = object.post
    post.featuredusers.map do |user|
      {username: user.username, id: user.id, avatar: url_for(user.avatar)}
    end
  end

  def artist_name
    post = object.post
    if post.artist
      return post.artist.name
    end
  end 
  def created_at
    post = object.post
    return post.created_at
  end
  def thumbnail
    post = object.post
    return url_for(post.thumbnail)
  end
  def songSpotifyId
    return object.post.song.spotify_id
  end




  def username
    post = object.post
    if post.user
      return post.user.username
    end
  end 

  def useravatar
    post = object.post
    if post.user
      return url_for(post.user.avatar)
    end
  end 
  def bandpicture
    post = object.post
    if post.band
      return url_for(post.band.picture)
    end
  end

  def comment_count
    post = object.post
    return post.comments.length
  end 

  def share_count
    post = object.post
    return post.shares.length
  end 
  def user_id
    post = object.post
    if post.user
      return post.user.id
    end
  end

  def band_id
    post = object.post
    if post.band
      return post.band.id
    end
  end

end
