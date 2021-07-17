class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :follows, :followed_by, :location, :instruments, :post_count, :chatrooms
  attribute :avatar, if: -> {object.avatar.present?}
  attribute :bio, if: -> {object.bio}
  has_many :bands
  has_many :influencers
  has_many :followedbands
  has_many :followedartists
  has_many :followedsongs
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
