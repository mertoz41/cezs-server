class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :follows, :followed_by, :location, :instruments, :post_count
  attribute :avatar, if: -> {object.avatar.present?}
  attribute :bio, if: -> {object.bio}
  has_many :bands
  has_many :influencers
  has_many :followedbands
  has_many :followedartists
  has_many :userevents
  has_many :songs
  has_many :userdescposts
  has_many :posts
  has_many :shares
  has_many :bandpostshares
  has_many :banddescpostshares
  has_many :userdescpostshares
  has_one :favoritesong
  has_one :favoriteartist
  has_one :favoritealbum
  has_many :featuredposts
  has_many :featureduserdescposts
  
  def created_at
    object.created_at.to_date
  end
  # def featuredposts
  #   object.featuredposts.map do |post|
  #     PostSerializer.new(post)
  #   end
  # end
  # def featureduserdescposts
  #   object.featureduserdescposts.map do |post|
  #     UserdescpostSerializer.new(post)
  #   end
  # end

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
