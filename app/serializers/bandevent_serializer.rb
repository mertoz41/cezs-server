class BandeventSerializer < ActiveModel::Serializer
  attributes :id, :address, :description, :latitude, :longitude, :event_date, :event_time
  belongs_to :band
end
