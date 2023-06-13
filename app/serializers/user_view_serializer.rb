class UserViewSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :bio, :upcoming_event, :instruments, :follows_count, :followers_count, :name
  attribute :avatar, if: -> {object.avatar.present?}
  has_many :bands
  has_many :genres
  has_one :location
  has_many :posts, serializer: ShortPostSerializer
  has_many :favoritesongs
  has_many :favoriteartists
  
  
  def upcoming_event
      events = object.events.where("event_date >= ?", Time.now).order('created_at ASC')
      return events.first
  end


  def created_at
    object.created_at.to_date
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
    return url_for(object.avatar)
  end
  
end
