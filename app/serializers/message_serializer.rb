class MessageSerializer < ActiveModel::Serializer
  attributes :id, :chatroom_id, :content, :user_id
end
