class UserdescpostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :clip, :description, :created_at, :username, :useravatar, :user_id, :share_count, :comment_count, :thumbnail, :genre, :genre_id, :instruments, :featuredusers, :view_count
  def clip
    url_for(object.clip)
  end
  def thumbnail
    url_for(object.thumbnail)
  end
  def view_count
    object.userdescpostviews.size
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
  def instruments
    object.instruments.map do |instrument|
      {id: instrument.id, name: instrument.name}
    end
  end
  def featuredusers
    object.featuredusers.map do |user|
      {username: user.username, id: user.id, avatar: url_for(user.avatar)}
    end
  end

end
