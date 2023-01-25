class MessageSerializer < ActiveModel::Serializer
  attributes :id, :chatroom_id, :content, :user_id, :seen, :created_at, :username

  def username
    return object.user.username
  end
end
