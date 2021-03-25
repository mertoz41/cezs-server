class ChatroomsController < ApplicationController

  def show
    chatroom = Chatroom.find(params[:id])
    render json: {messages: chatroom.messages}
  end
  def create
    chatroom = Chatroom.create(title: params[:title])
    ActionCable.server.broadcast "chatrooms_channel", chatroom
  end
end
