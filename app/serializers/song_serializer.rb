class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_name, :post_count, :user_count, :spotify_id, :album_name, :favoriteusers_count, :artist_id, :artistSpotifyId, :followingusers_count, :view_count, :instruments
  has_many :posts
  # has_many :bandposts
  
  def artist_name
    return object.artist.name
  end

  def artistSpotifyId
    return object.artist.spotify_id
  end

  def post_count
    # return object.posts.size + object.bandposts.size
    return 0
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

    # object.bandposts.each do |post|
    #   post.instruments.each do |instrument|
    #     if !instruments.include? instrument.name
    #     instruments.push(instrument.name)
    #     end
    #   end
    # end
    
    return instruments
  end

  def user_count
    return object.users.size
  end

  def album_name
    return object.album.name
  end

  def favoriteusers_count
    return object.favoriteusers.size
  end

  def followingusers_count
    return object.followingusers.size
  end

  def view_count
    view = 0
    object.posts.each do |post|
      view += post.postviews.size
    end
    return view
  end

end

