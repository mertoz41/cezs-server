class NotificationCreator
    def initialize(data)
        @action_user_id = data[:action_user_id]
        @user_id = data[:user_id]
        @comment_id = data[:comment_id] || nil
        @applaud_id = data[:applaud_id] || nil
        @event_id = data[:event_id] || nil
        @post_id = data[:post_id] || nil
        @band_id = data[:band_id] || nil
        @bandfollow_id = data[:bandfollow_id] || nil
    end

    def create!
        create_notification

    end
    private
    def create_notification
        @new_notification = Notification.create(
            action_user_id: @action_user_id, 
            user_id: @user_id, 
            comment_id: @comment_id,
            applaud_id: @applaud_id,
            event_id: @event_id,
            post_id: @post_id,
            band_id: @band_id,
            bandfollow_id: @bandfollow_id,
            seen: false)

        ActionCable.server.broadcast "notifications_channel_#{@user_id}", NotificationSerializer.new(@new_notification)
        # EVENTUALLY SEND OUTSIDE THE APP NOTIS 
        # client = Exponent::Push::Client.new
        # #     SendNotificationJob.perform_later(
            #         post.user.notification_token.token,
            #         "#{user.username} commented on your post!",
            #         CommentNotificationSerializer.new(@new_notification).as_json
            #     )
        # messages = [{
        #     to: @token[0],
        #     body: @body,
        #     data: @data
        # }]
        # handler = client.send_messages(messages)

    end
end