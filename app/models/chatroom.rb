class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :userchatrooms
    has_many :users, through: :userchatrooms

    def new_chat(params)
        # user = User.find(params[:user_id])
        # receiving_user = User.find(params[:receiver_id])
        # message = Message.create(content: params[:message], user_id: user.id, chatroom_id: self.id, seen: false)
        # user_chatroom = Userchatroom.create(chatroom_id: self.id, user_id: user.id)
        # receiving_chatroom = Userchatroom.create(chatroom_id: self.id, user_id: receiving_user.id)
        # # CHATROOM NEEDS TO BE DELIEVERED THROUGH NOTIFICATIONS CHANNEL OF THE RECIPIENT USER
        # ActionCable.server.broadcast "notifications_channel_#{ receiving_user.id}", ChatroomSerializer.new(self)
    end
end
