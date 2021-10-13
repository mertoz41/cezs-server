class ShortBandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :picture, :location, :genres, :instruments
  def picture
    url_for(object.picture)
  end
  
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end

  def instruments
    arr = []
    object.members.each do |user|
      user.instruments.each do |inst|
        if !arr.include?({id: inst.id, name: inst.name})
          arr.push({id: inst.id, name: inst.name})
        end
      end
    end
    return arr
  end


end
