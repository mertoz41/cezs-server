class FollowNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :action_user_id, :action_username, :action_user_avatar, :message, :created_at
  def action_username
    user = User.find(object.action_user_id)
    return user.username
  end

  def action_user_avatar
    user = User.find(object.action_user_id)
    return url_for(user.avatar)
  end
  
  def message
    return 'followed you.'
  end
end