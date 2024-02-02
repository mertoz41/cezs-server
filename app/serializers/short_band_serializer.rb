class ShortBandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :picture, :location, :genres, :instruments
  has_many :posts, serializer: ShortPostSerializer

  def picture
    return "#{ENV['CLOUDFRONT_API']}/#{object.picture.key}"
  end
  
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end
  def instruments
    member_instruments = object.members.map(&:instruments)
    if member_instruments.size > 0
      uniq = member_instruments.flatten!.uniq
      return uniq.map do |inst|
        {id: inst.id, name: inst.name}
      end
    else
      return []
    end  
  end

end
