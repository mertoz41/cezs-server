class ChatroomsController < ApplicationController

  def show
    chatroom = Chatroom.find(params[:id])
    render json: {messages: chatroom.messages}
  end
  def create
      chatroom = Chatroom.find_or_create_by(title: params[:title])
      user = User.find(params[:user_id])
      receiving_user = User.find(params[:receiver_id])
      user_chatroom = Userchatroom.find_or_create_by(chatroom_id: chatroom.id, user_id: user.id)
      receiving_chatroom = Userchatroom.find_or_create_by(chatroom_id: chatroom.id, user_id: receiving_user.id)
      message = Message.create(content: params[:message], user_id: user.id, chatroom_id: chatroom.id)
      serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(message)).serializable_hash
      ActionCable.server.broadcast "chatrooms_channel_#{chatroom.id}", serialized_data
      head :ok
    # chatroom = Chatroom.create(title: params[:title])
    # ActionCable.server.broadcast "chatrooms_channel", chatroom
  end
end
