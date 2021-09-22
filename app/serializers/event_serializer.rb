class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :address, :description, :latitude, :longitude, :event_date, :event_time, :user, :band
  def user
    if object.user
      user = {}
      user[:username] = object.user.username
      user[:avatar] = url_for(object.user.avatar)
      user[:id] = object.user.id
      return user
    end
  end
  def band
    if object.band
      band = {}
      band[:name] = object.band.name
      band[:avatar] = url_for(object.band.avatar)
      band[:id] = object.band.id
      return user
    end
  end
end
