class BandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :picture, :created_at, :instruments, :location, :followers_count, :songs, :view_count, :upcoming_audition, :upcoming_event
  attribute :bandbio, if: -> {object.bandbio}
  has_many :posts, serializer: ShortPostSerializer
  has_many :genres
  # has_many :auditions
  # has_many :events
  has_many :members, serializer: ShortUserSerializer
  
  def picture
    url_for(object.picture)
  end

  def songs
    object.songs.map do |song|
      {name: song.name, artist_name: song.artist.name, id: song.id, artist_id: song.artist.id}
    end
  end
  
  def upcoming_audition
    return object.auditions.last
  end
  
  def upcoming_event
      return object.events.last
  end

  def view_count
    views = 0
    object.posts.each do |post|
      views += post.postviews.size
    end
    return views 
  end

  def instruments
    insts = []
    object.members.each do |member|
      member.instruments.each do |inst|
        if !insts.include?({id: inst.id, name: inst.name})
          insts.push({id: inst.id, name: inst.name})
        end
      end
    end
    return insts
  end

  def created_at
    object.created_at.to_date
  end
  def bandbio
    return object.bandbio.description
  end
  def followers_count
    object.followers.size
  end

end
