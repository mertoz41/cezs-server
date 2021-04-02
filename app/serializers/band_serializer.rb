class BandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :description, :picture, :created_at, :location
  
  def picture
    url_for(object.picture)
  end

  def created_at
    object.created_at.to_date
  end

end
