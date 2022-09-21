class LocationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :latitude, :longitude, :city, :musician_count

  def musician_count
    return object.users.size + object.bands.size
  end

end
