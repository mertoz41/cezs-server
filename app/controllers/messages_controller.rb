class MessagesController < ApplicationController
  def create
    chatroom = Chatroom.find(params[:chatroom_id])
    user = User.find(params[:user_id])
    message = Message.create(chatroom_id: chatroom.id, user_id: user.id, content: params[:content])
    # serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(message)).serializable_hash
    # MessagesChannel.broadcast_to chatroom, message
    # MessagesChannel.broadcast_to(chatroom, serialized_data)
    ActionCable.server.broadcast "chatrooms_channel_#{chatroom.id}", message

    head :ok
  end
end
