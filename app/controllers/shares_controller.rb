class SharesController < ApplicationController

    def create
        user = User.find(params[:user_id])
        post = Post.find(params[:post_id])
        @nu_share = Share.create(user_id: user.id, post_id: post.id)

        # create notification for the owner of content
        new_notification = ShareNotification.create(user_id: post.user.id, post_id: post.id, action_user_id: user.id)
        if post.user.notification_token
            client = Exponent::Push::Client.new
            messages = [{
                to: post.user.notification_token.token,
                body: "#{user.username} shared your post!"
            }]
            handler = client.send_messages(messages)
        end
        # action_user_id: user.id

        render json: @nu_share, serializer: ShareSerializer
    end

    def destroy
        share = Share.find(params[:id])
        share.destroy
        render json: {message: "Success"}
    end 
    
end
