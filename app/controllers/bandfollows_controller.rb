class BandfollowsController < ApplicationController
    include Rails.application.routes.url_helpers

    def create
        user = User.find(params[:user_id])
        band = Band.find(params[:band_id])
        new_follow = Bandfollow.create(user_id: user.id, band_id: band.id)
        client = Exponent::Push::Client.new
        messages = []
        band.members.each do |member|
            @new_notification = FollowNotification.create(user_id: member.id, band_id: band.id, action_user_id: user.id, seen: false)
            if member.notification_token
                obj = {to: member.notification_token.token,
                        body: "#{user.username} commented on #{post.band.name}#{post.band.name.last == 's' ? "'" : "'s"} post!",
                        data: FollowNotificationSerializer.new(@new_notification)}

                messages.push(obj)
            end
        end
        handler = client.send_messages(messages)
        render json: {new_follow: new_follow}



    end 
    def destroy
        bandfollow = Bandfollow.find(params[:id])
        bandfollow.destroy
        render json: {message: 'succezs'}
    end

    def bandfollowers
        band = Band.find(params[:id])
        followers = band.followers.map do |user|
            {username: user.username, avatar: url_for(user.avatar), id: user.id}
        end
        render json: {followers: followers}
        

    end
end
