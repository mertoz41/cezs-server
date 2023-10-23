class BandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :picture, :created_at, :bio, :location, :followers_count, :songs, :upcoming_event, :instruments
  has_many :posts, serializer: ShortPostSerializer
  has_many :genres
  has_many :members, serializer: ShortUserSerializer
  
  def picture
    "#{ENV['CLOUDFRONT_API']}/#{object.picture.key}"
  end

  def bio
    if !object.bio
      return ""
    else
      object.bio
    end
  end

  def songs
    object.songs.map do |song|
      {name: song.name, artist_name: song.artist.name, id: song.id, artist_id: song.artist.id}
    end
  end
  
  def upcoming_event
      return object.events.last
  end

  def instruments
    uniqInsts = object.members.map(&:instruments).flatten!.uniq
      return uniqInsts.map do |inst|
        {id: inst.id, name: inst.name}
      end
      
  end
  def created_at
    object.created_at.to_date
  end

  def followers_count
    object.followers.size
  end

end
