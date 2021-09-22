class MessageSerializer < ActiveModel::Serializer
  attributes :id, :chatroom_id, :content, :user_id, :seen, :created_at
end
