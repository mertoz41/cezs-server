class ShortSongSerializer < ActiveModel::Serializer
  attributes :id, :name, :post_count

  def post_count
    return object.posts.size
  end


end