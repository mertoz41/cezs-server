class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :spotify_id, :artist_name, :artist_id, :favoriteusers_count, :post_count, :artistSpotifyId, :song_count, :followingusers_count, :posts, :view_count
  has_many :songs
  def posts
    return object.posts.map {|post| post.id}
  end
  def song_count
    return object.songs.size
  end
  def artist_name
    return object.artist.name
  end
  def favoriteusers_count
    return object.favoriteusers.size
  end
  def followingusers_count
    return object.followingusers.size
  end
  def post_count
    return object.posts.size
  end

  def artistSpotifyId
    return object.artist.spotify_id
  end
  def view_count
    count = 0
    object.posts.each do |post|
      count += post.postviews.length
    end
    return count
  end
  
end
