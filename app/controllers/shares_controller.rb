class SharesController < ApplicationController

    def create
        user = User.find(params[:user_id])
        post = Post.find(params[:post_id])
        @nu_share = Share.create(user_id: user.id, post_id: post.id)

        # create notification for the owner of content
        client = Exponent::Push::Client.new
        if post.user
            @new_notification = ShareNotification.create(user_id: post.user.id, post_id: post.id, action_user_id: user.id, seen: false)
            if post.user.notification_token
            messages = [{
                to: post.user.notification_token.token,
                body: "#{user.username} shared your post!",
                data: ShareNotificationSerializer.new(@new_notification)
            }]
            handler = client.send_messages(messages)
            end
        else
            # notifications for band members if post is a band post
            messages = []
            post.band.members.each do |member|
                @new_notification = ShareNotification.create(user_id: member.id, post_id: post.id, action_user_id: user.id, seen: false)
                if member.notification_token
                    obj = {to: member.notification_token.token,
                            body: "#{user.username} shared #{post.band.name}s post!",
                            data: ShareNotificationSerializer.new(@new_notification)}
                    messages.push(obj)
                end
            end
            handler = client.send_messages(messages)
        end

        render json: @nu_share, serializer: ShareSerializer
    end

    def destroy
        share = Share.find(params[:id])
        share.destroy
        render json: {message: "Success"}
    end 
    def seenotification
        noti = ShareNotification.find(params[:id])
        noti.update(seen: true)
    end
    
end
