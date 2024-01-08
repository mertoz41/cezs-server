class NewChatService
    def initialize( user_id, receiver_id, chatroom_id)
        @user_id = user_id
        @receiver_id = receiver_id
        @chatroom_id = chatroom_id
    end

    def start!
        create_chatroom

    end
    private
    def create_chatroom
        user_chatroom = Userchatroom.create(chatroom_id: @chatroom_id, user_id: @user_id)
        chatroom = Chatroom.find(@chatroom_id)
        # CHATROOM NEEDS TO BE DELIEVERED THROUGH NOTIFICATIONS CHANNEL OF THE RECIPIENT USER
        ActionCable.server.broadcast "notifications_channel_#{ @receiver_id}", ChatroomSerializer.new(chatroom)
        # client = Exponent::Push::Client.new
        # messages = [{
        #     to: @token[0],
        #     body: @body,
        #     data: @data
        # }]
        # handler = client.send_messages(messages)

    end
end