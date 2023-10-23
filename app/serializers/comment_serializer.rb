class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :comment, :user_id, :post_id, :username, :created_at
  attribute :avatar, if: -> {object.user.avatar.present?}
  def username
    user = User.find(object.user_id)
    return user.username
  end

  def avatar
    return "#{ENV['CLOUDFRONT_API']}#{object.user.avatar.key}"
  end
end
