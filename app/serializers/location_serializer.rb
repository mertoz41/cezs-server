class LocationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :latitude, :longitude, :city, :musician_count, :audition_count

  def musician_count
    return object.users.size + object.bands.size
  end

  def audition_count

    auditions_number = object.auditions.where('audition_date >= ?', Date.today).size
    return auditions_number
  end
end
