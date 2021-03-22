class MessagesController < ApplicationController
  def create
    chatroom = Chatroom.create(title: params[:title])
    user = User.find(params[:userId])
    message = Message.create(chatroom_id: chatroom.id, sender_id: user.id, content: params[:message])
    MessagesChannel.broadcast_to chatroom, message
  end
end
