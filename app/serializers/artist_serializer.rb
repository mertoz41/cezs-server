class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :influence_count, :song_count, :favoriteusers_count, :followingusers_count, :view_count, :instruments
  has_many :posts
  has_many :albums
  # has_many :albums
  # has_many :songs
  
  def influence_count
    return object.influencedusers.size
  end
  def song_count
    return object.songs.size
  end
  def favoriteusers_count
    return object.favoriteusers.size
  end
  def followingusers_count
    return object.followingusers.size
  end

  def instruments
    instruments = []
    object.posts.each do |post|
      post.instruments.each do |instrument|
        if !instruments.include? instrument.name
        instruments.push(instrument.name)
        end
      end
    end


    
    return instruments


  end

  def view_count
    views = 0
    object.posts.each do |post|
      views += post.postviews.size
    end
    
    return views

  end
  
end
