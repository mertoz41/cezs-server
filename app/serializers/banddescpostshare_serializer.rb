class BanddescpostshareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :description, :bandname, :bandpicture, :created_at, :share_count, :band_id, :comment_count, :banddescpost_id

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
  def bandpicture
    banddescpost = object.banddescpost
    return url_for(banddescpost.band.picture)
  end
  def created_at
    banddescpost = object.banddescpost
    return banddescpost.created_at
  end 
  def share_count
    banddescpost = object.banddescpost
    return banddescpost.banddescpostshares.size
  end
  def band_id
    banddescpost = object.banddescpost
    return banddescpost.band.id
  end
  def comment_count
    banddescpost = object.banddescpost
    return banddescpost.banddescpostcomments.size
  end 



    



end
