class PlaylistNotificationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :action_user_avatar, :action_username, :action_user_id, :message, :playlist_id, :playlist_name
  def action_username
    return object.playlist.playlist_user.username
  end
  def action_user_id
    return object.playlist.playlist_user.id
  end
  def playlist_name
    return object.playlist.name
  end
  def action_user_avatar
    return url_for(object.playlist.playlist_user.avatar)
  end
  def message
    return "#{object.playlist.playlist_user.username} added your post to #{object.playlist.name}."
  end
end
