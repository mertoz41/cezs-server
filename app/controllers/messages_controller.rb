class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    user = User.find(params[:user_id])
    message = Message.create(chatroom_id: @chatroom.id, user_id: user.id, content: params[:content], seen: false)
    other_user = @chatroom.users.select do |usr|
      usr.id != user.id
    end
    
    if other_user[0].notification_token
      SendNotificationJob.perform_later(
        other_user[0].notification_token.token,
        "#{user.username} sent you a message!",
        ChatroomSerializer.new(@chatroom).as_json
      )
    end
    ActionCable.server.broadcast "chatrooms_channel_#{params[:chatroom_id]}", message

    head :ok
  end

  def oldermessages
    message = Message.find(params[:id])
    chatroom = Chatroom.find(message.chatroom_id)
    messages = Message.where("created_at < ? AND chatroom_id = ?", "%#{message.created_at}%", chatroom.id)
    @ordered = messages.order(created_at: :asc).last(20)
    if @ordered.length == 0
      render json: {message: 'all messages displayed'}
    else
      render json: {messages: ActiveModel::Serializer::CollectionSerializer.new(@ordered, each_serializer: MessageSerializer)}
    end
  
  end

  
end
