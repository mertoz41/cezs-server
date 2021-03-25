class MessagesController < ApplicationController
  def create
    chatroom = Chatroom.find_or_create_by(title: params[:title])
    user = User.find(params[:userId])
    message = Message.create(chatroom_id: chatroom.id, user_id: user.id, content: params[:message])
    byebug
    serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(message)).serializable_hash
    # MessagesChannel.broadcast_to chatroom, message
    # MessagesChannel.broadcast_to(chatroom, serialized_data)
    ActionCable.server.broadcast "chatrooms_channel_#{chatroom.id}", serialized_data

    head :ok
  end
end
