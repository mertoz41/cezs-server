class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :last_message, :users, :last_message_time, :last_message_seen
  include Rails.application.routes.url_helpers

  def users
    object.users.map do |user|
      {id: user.id,
      avatar: url_for(user.avatar),
      username: user.username
    }
    end
  end

  def last_message
    if object.messages.length > 0
      return object.messages.last.content
    end
  end
  
  def last_message_time
    if object.messages.length > 0
      return object.messages.last.created_at
    end
  end
  def last_message_seen
    if object.messages.length > 0
      return object.messages.last.seen
    end
  end
end
