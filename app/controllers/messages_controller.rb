class MessagesController < ApplicationController
  require "base64"
  def create
    chatroom = Chatroom.find(params[:chatroom_id])
    user = User.find(params[:user_id])
    # byebug
    message = Message.create(chatroom_id: chatroom.id, user_id: user.id, content: params[:content], seen: false)
    # find chatrooms other users
    # check if they have token
    # if so send notifications
    # channels = Redis.new.pubsub('channels', 'action_cable/*')
    # tokens = channels.map do |channel|
    #   channel.delete('action_cable/')
    # end
    # plains = []
    # tokens.each do |token|
    #   plains.push(Base64.decode64(token))
    # end/
    # byebug
    # can i know if user is connected to the channel
    # serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(message)).serializable_hash
    # MessagesChannel.broadcast_to chatroom, message
    # MessagesChannel.broadcast_to(chatroom, serialized_data)
    ActionCable.server.broadcast "chatrooms_channel_#{chatroom.id}", message

    head :ok
  end

  
end
