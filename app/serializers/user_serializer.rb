class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :follows, :followed_by
  attribute :avatar, if: -> {object.avatar.present?}

  def created_at
    object.created_at.to_date
  end

  def avatar
    return url_for(object.avatar)
  end 

  # def follows
  #   # need the names of followed_id
  #   follows_arr = []
  #   object.follows.each do |follow|
  #     obj = {}
  #     obj = follow.attributes
  #     user = User.find(follow.followed_id)
  #     obj["name"] = user.username
  #     obj["avatar"] = url_for(user.avatar)
  #     follows_arr.push(obj)
  #   end 
  #   return follows_arr

  # end 
  # def followed_by
  #   # need the names of follower_id
  #   followed_by_arr = []
  #   object.followed_by.each do |follow|
  #     obj = {}
  #     obj = follow.attributes
  #     user = User.find(follow.follower_id)
  #     obj["name"] = user.username
  #     obj["avatar"] = url_for(user.avatar)
  #     followed_by_arr.push(obj)
  #   end 
  #   return followed_by_arr
  # end 
end
