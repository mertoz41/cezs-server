class CommentNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :post_id, :action_user_id, :action_username, :action_user_avatar, :message, :created_at, :seen

  def action_username
    user = User.find(object.action_user_id)
    return user.username
  end

  def action_user_avatar
    user = User.find(object.action_user_id)
    return url_for(user.avatar)
  end

  def message
    post = Post.find(object.post_id)
    if post.user
      return 'commented on your post.'
    else 
      return "commented on #{post.band.name}#{post.band.name.last == 's' ? "'" : "'s"}"
    end
  end


  
end
