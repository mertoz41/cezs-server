class BandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :picture, :created_at, :location
  attribute :bandbio, if: -> {object.bandbio}

  has_many :bandfollows
  has_many :bandposts
  has_many :members

  
  def picture
    url_for(object.picture)
  end

  def created_at
    object.created_at.to_date
  end

end
