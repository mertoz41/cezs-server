class UsereventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :address, :description, :latitude, :longitude, :event_date, :event_time, :user

  def user
    user = {}
    user[:username] = object.user.username
    user[:avatar] = url_for(object.user.avatar)
    user[:id] = object.user.id
    return user
  end

end
