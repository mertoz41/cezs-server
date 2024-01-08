class StartNewChatJob < ApplicationJob
    queue_as :default
  
    def perform(user_id, receiver_id, chatroom_id)
      NewChatService.new(user_id, receiver_id, chatroom_id).start!
    end
  end
  