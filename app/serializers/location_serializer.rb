class LocationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :user_id
end
