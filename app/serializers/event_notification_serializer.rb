class EventNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :event_id, :action_user_id, :performer_name, :performer_avatar, :message, :seen, :event_date, :created_at, :address, :latitude, :longitude
  
  def performer_avatar

    if object.performing_user
      return url_for(object.performing_user.avatar)
    else
      return url_for(object.performing_band.picture)
    end
  end
  def performer_name
    if object.performing_user
      return object.performing_user.username
    else
      return object.performing_band.name
    end
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
  def latitude
    return object.event.latitude
  end
  def longitude
    return object.event.longitude
  end

  
end
