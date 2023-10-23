class UserViewSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :bio, :upcoming_event, :instruments, :follows_count, :followers_count, :name, :posts, :applauds
  attribute :avatar, if: -> {object.avatar.present?}
  has_many :bands
  has_many :genres
  has_one :location
  has_many :favoritesongs
  has_many :favoriteartists
  
  
  def upcoming_event
      events = object.events.where("event_date >= ?", Time.now).order('created_at ASC')
      return events.first
  end
  def posts
    all_posts = object.posts
    if object.bands.size > 0
      all_posts = all_posts + object.bands.map(&:posts).flatten!
    end
    filtered_posts = all_posts.select {|post| post.reports.size < 1}
    filtered_posts.map {|post| ShortPostSerializer.new(post)}
  end


  def created_at
    object.created_at.to_date
  end

  def applauds
    applauds = object.applauds.map(&:post)
    return applauds.map do |post| ShortPostSerializer.new(post)
    end
  end

  def instruments
    object.instruments.map do |inst|
      {id: inst.id, name: inst.name}
    end
  end

  def followers_count
    object.followers.size
  end

  def follows_count
    object.follows.size + object.followedbands.size + object.followedartists.size + object.followedsongs.size
  end

  def avatar
    return "#{ENV['CLOUDFRONT_API']}/#{object.avatar.key}"
  end
  
end
