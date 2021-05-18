class UserdescpostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :clip, :description, :instrument_id, :created_at, :username, :useravatar, :user_id, :share_count, :comment_count, :thumbnail, :genre, :genre_id
  def clip
    url_for(object.clip)
  end
  def genre
    return object.genre.name
  end
  def username
    user = User.find(object.user_id)
    return user.username
  end
  def useravatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
  def share_count
    return object.userdescpostshares.size
  end
  def comment_count
    return object.userdescpostcomments.size
  end
end
