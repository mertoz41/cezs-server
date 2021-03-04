class LocationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :latitude, :longitude, :user_count, :city

  def user_count
    return object.users.length
  end
  
end
