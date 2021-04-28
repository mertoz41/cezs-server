class BanddescpostshareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :description, :bandname, :band_picture
  def clip
    banddescpost = object.banddescpost
    return url_for(banddescpost.clip)
  end 
  def description
    banddescpost = object.banddescpost
    return banddescpost.description
  end
  def bandname
    banddescpost = object.banddescpost
    return banddescpost.band.name
  end
  def band_picture
    banddescpost = object.banddescpost
    return url_for(banddescpost.band.picture)
  end


end
