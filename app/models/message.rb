class Message < ApplicationRecord
    belongs_to :chatroom
    belongs_to :sender, class_name: :User, foreign_key: 'sender_id'

    after_create_commit { MessageBroadcastJob.perform_later(self)}
end
