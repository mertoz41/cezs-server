class AuditionNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :audition_id, :action_username, :action_user_avatar, :message, :seen, :created_at, :audition_date, :location_id, :latitude, :longitude, :city
  def location_id
    return object.audition.location.id
  end
  def city
    return object.audition.location.city
  end
  def latitude
    return object.audition.location.latitude
  end

  def longitude
    return object.audition.location.longitude
  end
  def action_user_avatar
    if object.auditing_user
      return url_for(object.auditing_user.avatar)
    else
      return url_for(object.auditing_band.picture)
    end
  end
  def action_username
    if object.auditing_user
      return object.auditing_user.username
    else
      return object.auditing_band.name
    end
  end
  def audition_date
    return object.audition.audition_date
  end

  def message
    return 'has an upcoming audition.'
  end
end
