class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :followed_by, :location, :instruments, :post_count, :chatrooms, :follows_count, :followed_users, :followed_artists, :followed_songs, :followed_bands, :followers_count, :view_count, :share_count
  attribute :avatar, if: -> {object.avatar.present?}
  attribute :bio, if: -> {object.bio}
  has_many :bands
  has_many :influencers
  has_many :userevents
  has_many :songs
  has_many :userdescposts
  has_many :posts
  has_many :shares
  has_many :bandpostshares
  has_many :banddescpostshares
  has_many :userdescpostshares
  has_many :favoritesongs
  has_many :favoriteartists
  has_many :favoritealbums
  has_many :featuredposts
  has_many :featureduserdescposts
  # has_many :chatrooms 
  
  def created_at
    object.created_at.to_date
  end

  def share_count
    shares = 0
    object.posts.each do |post|
      shares += post.shares.size
    end
    object.userdescposts.each do |post|
      shares += post.userdescpostshares.size
    end
    return shares

  end

  def view_count
    views = 0
    object.posts.each do |post|
      views += post.postviews.size
    end
    object.userdescposts.each do |post|
      views += post.userdescpostviews.size
    end
    return views
  end

  def followers_count
    object.followers.size
  end

  def followed_bands
    object.followedbands.map do |band|
      band.id
    end
  end

  def follows_count
    object.follows.size + object.followedbands.size + object.followedartists.size + object.followedsongs.size
  end

  def followed_users
    object.followeds.map do |user|
      user.id
    end
  end

  def followed_songs
    object.followedsongs.map do |song|
      song.spotify_id
    end
  end

  def followed_artists
      object.followedartists.map do |artist|
      artist.spotify_id
    end

  end

  def chatrooms
    object.chatrooms.map do |room|
      users = room.users.filter { |user| user != object}
      users_wit_avatar = users.map do |user|
        {username: user.username, id: user.id, avatar: url_for(user.avatar)}
      end
      {users: users_wit_avatar, room_id: room.id}
    end
  end
  
  def avatar
    return url_for(object.avatar)
  end
  def bio 
    return object.bio.description
  end
  def post_count
    return object.posts.length
  end
end
