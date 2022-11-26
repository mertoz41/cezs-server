class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :comment, :user_id, :post_id, :username, :created_at
  attribute :avatar, if: -> {object.user.avatar.present?}
  def username
    user = User.find(object.user_id)
    return user.username
  end

  def avatar
    return url_for(object.user.avatar)
  end
end
