class BandfollowsController < ApplicationController
    include Rails.application.routes.url_helpers

    def follow
        band = Band.find(params[:id])
        new_follow = Bandfollow.create(user_id: logged_in_user.id, band_id: band.id)
        band.members.each do |member|
            @new_notification = Notification.create(user_id: member.id, action_user_id: logged_in_user.id, seen: false, bandfollow_id: new_follow.id, band_id: band.id)
            ActionCable.server.broadcast "notifications_channel_#{member.id}", NotificationSerializer.new(@new_notification)

            # if member.notification_token
            #     SendNotificationJob.perform_later(
            #         member.notification_token.token,
            #         "#{logged_in_user.username} is following #{band.name}!",
            #         FollowNotificationSerializer.new(@new_notification).as_json
            #     )
            # end
        end
        render json: {message: 'is followed.'}
    end 
    
    def unfollow
        bandfollow = Bandfollow.find_by(user_id: logged_in_user.id, band_id: params[:id])
        bandfollow.destroy
        render json: {message: 'unfollowed.'}
    end

    def bandfollowers
        band = Band.find(params[:id])
        followers = band.followers.map do |user|
            obj = {id: user.id, username: user.username}
            if user.avatar.attached?
                obj["avatar"] = "#{ENV['CLOUDFRONT_API']}#{user.avatar.key}"
            end
            obj
        end
        render json: {followers: followers}
    end
end
