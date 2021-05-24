class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :comment, :user_id, :post_id, :username, :avatar, :created_at
  def username
    user = User.find(object.user_id)
    return user.username
  end
  # def created_at
  #   object.created_at.to_date
  # end 
  def avatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
end
