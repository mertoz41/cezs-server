class MessagesController < ApplicationController
  require "base64"
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    user = User.find(params[:user_id])
    message = Message.create(chatroom_id: @chatroom.id, user_id: user.id, content: params[:content], seen: false)
    other_user = @chatroom.users.select do |usr|
      usr.id != user.id
    end
    
    if other_user[0].notification_token
      client = Exponent::Push::Client.new
      messages = [{
        to: other_user[0].notification_token.token,
        body: "#{user.username} sent you a message!",
        data: ChatroomSerializer.new(@chatroom)
      }]
      handler = client.send_messages(messages)

    end

    # find other user that is outside this user,
    # check if it has token if so send notification

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
    ActionCable.server.broadcast "chatrooms_channel_#{params[:chatroom_id]}", message

    head :ok
  end

  def oldermessages
    message = Message.find(params[:id])
    chatroom = Chatroom.find(message.chatroom_id)
    # ordered = chatroom.messages.order(created_at: :asc)
    messages = Message.where("created_at < ? AND chatroom_id = ?", "%#{message.created_at}%", chatroom.id)
    @ordered = messages.order(created_at: :asc).last(20)
    # byebug
    if @ordered.length == 0
      render json: {message: 'all messages displayed'}
    else
      render json: {messages: ActiveModel::Serializer::CollectionSerializer.new(@ordered, each_serializer: MessageSerializer)}
    end
    # @older_messages = chatroom.messages.where("created_at < ?", "%#{message.created_at}%").order("created_at DESC")
    # # @ordered = older_messages.order(created_at: :asc).first(10)
    # # get messages that are older than this message in that chatroom
    # older_messages = Message.where("chatroom_id = ? AND created_at < ?", "%#{message.chatroom_id}%", "%#{message.created_at}%")
  end

  
end
