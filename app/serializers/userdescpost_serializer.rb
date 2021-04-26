class UserdescpostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :description, :instrument_id, :created_at, :username, :useravatar
  
  def clip
    url_for(object.clip)
  end
  def created_at
    object.created_at.to_date
  end
  def username
    user = User.find(object.user_id)
    return user.username
  end
  def useravatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
end
