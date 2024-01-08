class ChatroomsController < ApplicationController

  def show
    chatroom = Chatroom.find(params[:id])
    ordered = chatroom.messages.order(created_at: :asc).last(10)
    render json: {messages: ordered}
  end
  def create
    # LOOK FOR a chatroom that has both users before creating one
      @chatroom = Chatroom.new
      @chatroom.save
      @message = Message.create(content: params[:message], user_id: logged_in_user.id, chatroom_id: @chatroom.id, seen: false)
      receiving_chatroom = Userchatroom.create(chatroom_id: @chatroom.id, user_id: params[:receiver_id])
      StartNewChatJob.perform_later(
        logged_in_user.id,
        params[:receiver_id],
        @chatroom.id
        )

      render json: {chatroom: ChatroomSerializer.new(@chatroom), message: @message}
  end
  def seemessages
    Message.where(user_id: params[:user_id], chatroom_id: params[:chatroom_id]).update_all(seen: true)
    render json: {message: 'all messages seen.'}
  end
end
