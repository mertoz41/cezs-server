class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :last_message, :users
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
    if object.messages.size > 0
      return object.messages.last
    end
  end

end
