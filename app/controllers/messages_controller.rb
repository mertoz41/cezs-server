class MessagesController < ApplicationController
  def create
    chatroom = Chatroom.find_or_create_by(title: params[:title])
    user = User.find(params[:userId])
    byebug
    message = Message.create(chatroom_id: chatroom.id, user_id: user.id, content: params[:message])
    MessagesChannel.broadcast_to chatroom, message
  end
end
