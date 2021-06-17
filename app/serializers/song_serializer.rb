class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name, :post_count, :user_count, :bandpost_count, :spotify_id, :album_name, :favoriteusers_count
  has_many :posts
  has_many :bandposts
  
  def artist_name
    return object.artist.name
  end
  def post_count
    return object.posts.size
  end
  def user_count
    return object.users.size
  end
  def bandpost_count
    return object.bandposts.size
  end
  def album_name
    return object.album.name
  end
  def favoriteusers_count
    return object.favoriteusers.size
  end
end

