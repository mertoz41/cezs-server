class BandeventSerializer < ActiveModel::Serializer
  attributes :id, :address, :description, :latitude, :longitude, :event_date
  belongs_to :band
end
