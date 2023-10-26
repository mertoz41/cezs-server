class Applaud < ApplicationRecord
    belongs_to :applauding_user, class_name: "User", foreign_key: 'user_id'
    belongs_to :post
    has_many :notifications, dependent: :destroy

    def send_notifications(user_id)
        if self.post.user
            @new_notification = Notification.create(
                applaud_id: self.id, 
                user_id: self.post.user.id, 
                action_user_id: user_id, 
                seen: false
                )
            ActionCable.server.broadcast "notifications_channel_#{ self.post.user.id}", NotificationSerializer.new(@new_notification)
        else
            self.post.band.members.each do |member|
                @new_notification = Notification.create(applaud_id: self.id, user_id: member.id, action_user_id: user_id, seen: false)
                ActionCable.server.broadcast "notifications_channel_#{ member.id}", NotificationSerializer.new(@new_notification)
            end
        end
        # if applaud.post.user.notification_token
        #     #     SendNotificationJob.perform_later(
        #     #         applaud.post.user.notification_token.token,
        #     #         "#{@new_notification.applauding_user.username} applauded your post.",
        #     #         ApplaudNotificationSerializer.new(@new_notification).as_json

        #     #     )
        #     # end

    end
end
