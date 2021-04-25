class BandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :picture, :created_at, :location
  attribute :bandbio, if: -> {object.bandbio}

  has_many :users
  has_many :bandposts
  has_many :members
  has_many :bandevents
  has_many :songs
  has_many :banddescposts
  
  def picture
    url_for(object.picture)
  end

  def created_at
    object.created_at.to_date
  end

end
