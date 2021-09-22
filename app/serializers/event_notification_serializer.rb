class EventNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :event_id, :action_user_id, :action_username, :action_user_avatar, :message, :seen, :event_date, :created_at, :address
  def action_user_avatar
    user = User.find(object.action_user_id)
    return url_for(user.avatar)
  end
  def action_username
    user = User.find(object.action_user_id)
    return user.username
  end
  def message
    return ' is performing'
  end
  def event_date
    # event = Event.find(object.event_id)
    return object.event.event_date
  end
  def address
    return object.event.address
  end
end
