class ShortBandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :picture, :location, :genres
  def picture
    url_for(object.picture)
  end
  
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end

end
