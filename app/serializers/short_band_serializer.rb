class ShortBandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :picture, :location, :genres, :instruments
  has_many :posts, serializer: ShortPostSerializer

  def picture
    url_for(object.picture)
  end
  
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end
  def instruments
    uniqInsts = object.members.map(&:instruments).flatten!.uniq
      return uniqInsts.map do |inst|
        {id: inst.id, name: inst.name}
      end
      
  end

end
