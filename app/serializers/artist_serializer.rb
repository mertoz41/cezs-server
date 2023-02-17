class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :song_count, :favoriteusers_count, :followingusers_count, :post_count, :view_count
  has_many :albums
  
  def post_count
    return object.posts.size
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
    count = 0
    object.posts.each do |post|
      count += post.postviews.length
    end
    return count
  end
end
