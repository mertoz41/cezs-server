class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name, :post_count
  def artist_name
    return object.artist.name
  end
  def post_count
    return object.posts.size
  end 
end
