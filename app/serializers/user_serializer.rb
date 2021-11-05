class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :location, :instruments, :post_count, :follows_count, :followed_users, :followed_artists, :followed_songs, :followed_bands, :followed_albums, :followers_count, :name, :last_name, :email, :notification_token, :applauds
  attribute :avatar, if: -> {object.avatar.present?}
  attribute :bio, if: -> {object.bio}
  attribute :upcoming_event, if: -> {object.events.present?}
  attribute :upcoming_audition, if: -> {object.auditions.present?}
  has_many :bands
  has_many :genres
  has_many :influencers
  has_many :posts, serializer: ShortPostSerializer
  has_many :favoritesongs
  has_many :favoriteartists
  has_many :favoritealbums
  has_many :featuredposts, serializer: ShortPostSerializer
  has_many :playlists
  def notification_token
    if object.notification_token
      return object.notification_token.token
    else
      return nil
    end
  end

  def upcoming_audition
    auditions = object.auditions.where("audition_date >= ?", Time.now.beginning_of_day)
    return AuditionSerializer.new(auditions.first)
  end
  
  def upcoming_event
      events = object.events.where("event_date >= ?", Time.now.beginning_of_day)
      return EventSerializer.new(events.first)
  end
  def applauds
    object.applauds.map do |appl|
      appl.post_id
    end
  end
  
  def created_at
    object.created_at.to_date
  end

  def instruments
    object.instruments.map do |inst|
      {id: inst.id, name: inst.name}
    end
  end
  # def view_count
  #   views = 0
  #   object.posts.each do |post|
  #     views += post.postviews.size
  #   end
  #   return views
  # end

  def followers_count
    object.followers.size
  end

  def followed_bands
    object.followedbands.map do |band|
      band.id
    end
  end

  def followed_albums
    object.followedalbums.map do |album|
      album.spotify_id
    end
  end

  def follows_count
    object.follows.size + object.followedbands.size + object.followedartists.size + object.followedsongs.size + object.followedalbums.size
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
