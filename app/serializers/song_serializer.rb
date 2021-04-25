class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name, :post_count, :user_count
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
end
