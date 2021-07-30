class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :influence_count, :song_count, :favoriteusers_count, :followingusers_count, :view_count
  has_many :bandposts
  has_many :posts
  has_many :songs
  
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

  def view_count
    views = 0
    object.posts.each do |post|
      views += post.postviews.size
    end
    object.bandposts.each do |post|
      views += post.bandpostviews.size
    end
    return views

  end
  
end
