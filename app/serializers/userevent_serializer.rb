class UsereventSerializer < ActiveModel::Serializer
  attributes :id, :address, :description, :latitude, :longitude, :event_date
  belongs_to :user

end
