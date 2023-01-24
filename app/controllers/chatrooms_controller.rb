class ChatroomsController < ApplicationController

  def show
    chatroom = Chatroom.find(params[:id])
    ordered = chatroom.messages.order(created_at: :asc).last(10)
    render json: {messages: ordered}
  end
  def create
      @chatroom = Chatroom.new
      @chatroom.save
      user = User.find(params[:user_id])
      receiving_user = User.find(params[:receiver_id])
      message = Message.create(content: params[:message], user_id: user.id, chatroom_id: @chatroom.id, seen: false)
      user_chatroom = Userchatroom.create(chatroom_id: @chatroom.id, user_id: user.id)
      receiving_chatroom = Userchatroom.create(chatroom_id: @chatroom.id, user_id: receiving_user.id)
      # serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(message)).serializable_hash
      render json: {chatroom: ChatroomSerializer.new(@chatroom), message: message}
      # ActionCable.server.broadcast "chatrooms_channel_#{chatroom.id}", serialized_data
      # head :ok
    # chatroom = Chatroom.create(title: params[:title])
    # ActionCable.server.broadcast "chatrooms_channel", chatroom
  end
  def seemessages
    Message.where(user_id: params[:user_id], chatroom_id: params[:chatroom_id]).update_all(seen: true)
    # Messages.where('chatroom_id LIKE ?', "%#{params[:id]}%").update_all(seen: true)
    render json: {message: 'all messages seen.'}
  end
end
