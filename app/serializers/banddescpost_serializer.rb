class BanddescpostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :description, :created_at, :bandname, :bandpicture, :band_id, :comment_count, :share_count
  has_many :instruments
  def clip
    url_for(object.clip)
  end
  def bandname
    band = Band.find(object.band_id)
    return band.name
  end
  def bandpicture
    band = Band.find(object.band_id)
    return url_for(band.picture)
  end
  def comment_count
    return object.banddescpostcomments.size
  end
  def share_count
    return object.banddescpostshares.size
  end
end
