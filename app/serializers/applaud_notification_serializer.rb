class ApplaudNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :action_username, :action_user_avatar, :action_user_id, :message, :applaud_id, :post_id, :created_at, :seen, :applaud_noti
  def action_username
    return object.applauding_user.username
  end

  def applaud_noti
    true
  end

  def action_user_id
    return object.applauding_user.id
  end

  def post_id
    return object.applaud.post.id
  end

  def action_user_avatar
    return url_for(object.applauding_user.avatar)
  end

  def message 
    if object.applaud.post.user
      return "applauded your post."
    else
      return "applauded #{object.applaud.post.band.name}#{object.applaud.post.band.name.last == 's' ? "'" : "'s"} post."
    end

  end


end
