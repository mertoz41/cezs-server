class ShareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :post_id, :user_id, :clip, :song_name, :useravatar, :artist_name, :username, :share_count, :comment_count, :artist_id, :created_at

  def clip
    post = object.post
    return url_for(post.clip)
  end

  def artist_id
    post = object.post
    return post.artist.id
  end

  def song_name
    post = object.post
    return post.song.name
  end 

  def artist_name
    post = object.post
    return post.artist.name
  end 
  def created_at
    post = object.post
    return post.created_at
  end



  def username
    post = object.post
    return post.user.username
  end 

  def useravatar
    post = object.post
    user = User.find(post.user_id)
    return url_for(user.avatar)
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
    return post.user.id
  end

end
