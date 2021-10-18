class AuditionNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :audition_id, :performer_name, :performer_avatar, :message, :seen, :created_at

  def performer_avatar
    if object.auditing_user
      return url_for(object.auditing_user.avatar)
    else
      return url_for(object.auditing_band.picture)
    end
  end
  def performer_name
    if object.auditing_user
      return object.auditing_user.username
    else
      return object.auditing_band.name
    end
  end

  def message
    return 'has an upcoming audition.'
  end
end
