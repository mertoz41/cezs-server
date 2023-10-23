class NotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :action_user_id, :seen, :created_at, :message
  attribute :avatar, if: -> {object.action_user.avatar.attached?}
  attribute :post_id, if: -> {object.comment_id || object.applaud_id}
  attribute :thumbnail, if: -> {object.comment_id || object.applaud_id || object.band_id}
  attribute :band_id, if: -> {object.band_id}
  attribute :bandname, if: -> {object.band_id}

  def message
    username = object.action_user.username
   if object.applaud_id
      message = " applauded your post"
    elsif object.comment_id
      message = " commented on your post"
    elsif object.event_id
      message = " has an upcoming event near you"
    elsif object.bandfollow_id
      message = " follows" + " " + object.band.name
    elsif object.band_id
      message = " added you to " + object.band.name
    else
      message = " follows you"
    end
    return username + message
  end

  def avatar
    if object.action_user.avatar.attached?
    return "#{ENV['CLOUDFRONT_API']}#{object.action_user.avatar.key}"
    end
  end

  def post_id
    if object.comment_id
      return object.comment.post.id
    else 
      return object.applaud.post.id
    end
  end

  def thumbnail
    if object.comment_id
      return "#{ENV['CLOUDFRONT_API']}#{object.comment.post.thumbnail.key}"
    elsif object.applaud_id
      return "#{ENV['CLOUDFRONT_API']}#{object.applaud.post.thumbnail.key}"
    elsif object.band_id
      return "#{ENV['CLOUDFRONT_API']}#{object.band.picture.key}"
    end 
  end
  def bandname
    return object.band.name
  end
  
end
