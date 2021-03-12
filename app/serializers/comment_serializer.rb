class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :comment, :user_id, :post_id, :username, :avatar
  def username
    user = User.find(object.user_id)
    return user.username
  end
  def avatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
end
