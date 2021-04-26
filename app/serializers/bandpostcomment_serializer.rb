class BandpostcommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :comment, :created_at, :username, :avatar, :bandpost_id
  def username
    user = User.find(object.user_id)
    return user.username
  end
  def avatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
end
