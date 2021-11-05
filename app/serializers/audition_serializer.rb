class AuditionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :description, :audition_date, :created_at, :instruments, :genres
  attribute :user_id, if: -> {object.user.present?}
  attribute :band_id, if: -> {object.band.present?}
  attribute :useravatar, if: -> {object.user.present?}
  attribute :username, if: -> {object.user.present?}
  attribute :bandname, if: -> {object.band.present?}
  attribute :bandpicture, if: -> {object.band.present?}
  belongs_to :location


  def useravatar
    return url_for(object.user.avatar)
  end
  def bandname
    return object.band.name
  end
  def bandpicture
    return url_for(object.band.picture)
  end
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end
  def instruments
    object.instruments.map do |inst|
      {id: inst.id, name: inst.name}
    end
  end
  def username
    return object.user.username
  end
end
