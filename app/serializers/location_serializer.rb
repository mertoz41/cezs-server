class LocationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :latitude, :longitude, :user_id, :avatar, :username
  def avatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
  def username
    user = User.find(object.user_id)
    return user.username
  end 
end
