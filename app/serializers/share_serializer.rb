class ShareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :post_id, :user_id, :clip, :song_name, :user_avatar, :artist_name, :username, :instrument_name, :genre_name, :share_count, :comment_count

  def clip
    post = object.post
    return url_for(post.clip)
  end

  def song_name
    post = object.post
    return post.song.name
  end 

  def artist_name
    post = object.post
    return post.artist.name
  end 

  def username
    post = object.post
    return post.user.username
  end 

  def user_avatar
    post = object.post
    user = User.find(post.user_id)
    return url_for(user.avatar)
  end 
  def instrument_name
    post = object.post
    return post.instrument.name
  end 
  def genre_name
    post = object.post
    return post.genre.name
  end 

  def comment_count
    post = object.post
    return post.comments.length
  end 

  def share_count
    post = object.post
    return post.shares.length
  end 

end
