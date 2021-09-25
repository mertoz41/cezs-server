class BandSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :picture, :created_at, :location, :followers_count, :members, :songs, :view_count, :share_count
  attribute :bandbio, if: -> {object.bandbio}
  has_many :posts
  has_many :events
  # has_many :bandposts
  # has_many :bandevents
  # has_many :banddescposts
  
  def picture
    url_for(object.picture)
  end

  def songs
    object.songs.map do |song|
      {name: song.name, artist_name: song.artist.name, id: song.id, artist_id: song.artist.id}
    end
  end

  def members
    object.members.map do |member|
    instruments = []
      if member.instruments.length
        member.instruments.each do |inst|
        instruments.push(inst.id)
        end
      end
      {username: member.username, avatar: url_for(member.avatar), id: member.id, instruments: instruments}
    end
  end

  def view_count
    views = 0
    object.posts.each do |post|
      views += post.postviews.size
    end
    return views 
  end

  def share_count
    shares = 0

    object.posts.each do |post|
      shares += post.shares.size
    end
    return shares
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
