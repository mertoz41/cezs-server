class BandfollowsController < ApplicationController
    include Rails.application.routes.url_helpers

    def follow
        band = Band.find(params[:id])
        new_follow = Bandfollow.create(user_id: logged_in_user.id, band_id: band.id)
        band.members.each do |member|
            @new_notification = FollowNotification.create(user_id: member.id, band_id: band.id, action_user_id: logged_in_user.id, seen: false)
            if member.notification_token
                SendNotificationJob.perform_later(
                    member.notification_token.token,
                    "#{logged_in_user.username} is following #{band.name}!",
                    FollowNotificationSerializer.new(@new_notification).as_json
                )
            end
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
            {username: user.username, avatar: url_for(user.avatar), id: user.id}
        end
        render json: {followers: followers}
    end
end
