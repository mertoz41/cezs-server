class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :last_message, :users, :last_message_time
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
    return object.messages.last.content
  end
  
  def last_message_time
    return object.messages.last.created_at
  end
end
