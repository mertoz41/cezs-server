class ChatroomsController < ApplicationController
  def create
    chatroom = Chatroom.create(title: params[:title])
    ActionCable.server.broadcast "chatrooms_channel", chatroom
  end
end
