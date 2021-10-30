class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :post_count, :posts, :user_id

  def post_count
    return object.posts.size
  end
  def posts
    object.posts.map do |post|
      post.id
    end
  end
end
