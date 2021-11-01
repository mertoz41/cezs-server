class ApplaudsController < ApplicationController
    def applaudpost
        applaud = Applaud.create(post_id: params[:post_id], user_id: params[:user_id])
        client = Exponent::Push::Client.new
        messages = []
        if applaud.post.user
            @new_notification = ApplaudNotification.create(applaud_id: applaud.id, user_id: applaud.post.user.id, action_user_id: params[:user_id], seen: false)
            if applaud.post.user.notification_token
            obj = {
                to: applaud.post.user.notification_token.token,
                body: "#{@new_notification.applauding_user.username} applauded your post.",
                data: ApplaudNotificationSerializer.new(@new_notification)
            }
            messages.push(obj)
            end
        else
            applaud.post.band.members.each do |member|
                @new_notification = ApplaudNotification.create(applaud_id: applaud.id, user_id: member.id, action_user_id: params[:user_id], seen: false)
                if member.notification_token
                    obj = {to: member.notification_token.token,
                            body: "#{@new_notification.applauding_user.username} applauded #{applaud.post.band.name}#{applaud.post.band.name.last == 's' ? "'" : "'s"} post!",
                            data: ApplaudNotificationSerializer.new(@new_notification)}
                    messages.push(obj)
                end
            end
            # post is a band post, check all members of band

        end
        handler = client.send_messages(messages)

        render json: {message: 'post applauded.'}
    end

    def unapplaudpost
        applaud = Applaud.find_by(user_id: params[:user_id], post_id: params[:post_id])
        applaud.destroy
        render json: {message: 'post unapplauded.'}
    end
end
