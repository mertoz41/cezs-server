class NotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :action_user_id, :seen, :created_at, :message
  attribute :avatar, if: -> {object.action_user.avatar.attached?}
  attribute :post_id, if: -> {object.comment_id || object.applaud_id}
  attribute :thumbnail, if: -> {object.comment_id || object.applaud_id}

  def message 
    username = object.action_user.username
   if object.applaud_id
      message = " applauded your post"
    elsif object.comment_id
      message = " commented on your post"
    elsif object.event_id
      message = " has an upcoming event near you"
    else 
      message = " follows you"
    end
    return username + message
  end

  def avatar
    if object.action_user.avatar.attached?
    return url_for(object.action_user.avatar)
    end
  end

  def post_id
    if object.comment_id
      return object.comment.post.id
    else 
      return object.applaud.post.id
    end
  end

  def thumbnail
    if object.comment_id
      return url_for(object.comment.post.thumbnail)
    else
      return url_for(object.applaud.post.thumbnail)
    end
  end
  
end
