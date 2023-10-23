class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :address, :description, :latitude, :longitude, :event_date, :event_time, :is_audition
  has_many :instruments
  has_many :genres
  attribute :band, if: -> {object.band}
  attribute :user, if: -> {object.user}
  attribute :band_id, if: -> {object.band}
  attribute :user_id, if: -> {object.user}

  def user
    if object.user
      user = {}
      user[:username] = object.user.username
      if object.user.avatar.attached?
        user[:avatar] = "#{ENV['CLOUDFRONT_API']}#{object.user.avatar.key}"
      end
      user[:id] = object.user.id
      return user
    end
  end
  def band
    if object.band
      band = {}
      band[:name] = object.band.name
      band[:picture] = "#{ENV['CLOUDFRONT_API']}#{object.band.picture.key}"
      band[:id] = object.band.id
      return band
    end
  end
end
