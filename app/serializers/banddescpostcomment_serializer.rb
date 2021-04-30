class BanddescpostcommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :comment, :banddescpost_id, :username, :avatar, :created_at
  def username
    user = User.find(object.user_id)
    return user.username
  end
  def avatar
    user = User.find(object.user_id)
    return url_for(user.avatar)
  end
end
