class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name, :user_count, :favoriteusers_count, :artist_id, :followingusers_count, :post_count, :view_count

  def post_count
    return object.posts.size
  end
  def artist_name
    return object.artist.name
  end


  def user_count
    return object.users.size
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

