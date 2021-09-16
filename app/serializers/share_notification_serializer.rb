class ShareNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :post_id, :action_user_id, :action_username, :action_user_avatar, :message, :post_thumbnail, :created_at, :seen

  def action_username
    user = User.find(object.action_user_id)
    return user.username
  end

  def action_user_avatar
    user = User.find(object.action_user_id)
    return url_for(user.avatar)
  end

  def message
    return 'shared your post.'
  end

  def post_thumbnail
    post = Post.find(object.post_id)
    return url_for(post.thumbnail)
  end
end
