class BandfollowsController < ApplicationController
    include Rails.application.routes.url_helpers

    def create
        band = Band.find(params[:id])
        new_follow = Bandfollow.create(user_id: logged_in_user.id, band_id: band.id)
        band.members.each do |member|
            CreateNotificationJob.perform_async(JSON.parse({user_id: member.id, action_user_id: logged_in_user.id, bandfollow_id: new_follow.id, band_id: band.id}.to_json))
        end
        render json: {message: 'is followed.'}
    end 
    
    def destroy
        bandfollow = Bandfollow.find_by(user_id: logged_in_user.id, band_id: params[:id])
        bandfollow.destroy
        render json: {message: 'unfollowed.'}
    end

    def show
        band = Band.find(params[:id])
        followers = band.followers.map do |user|
            obj = {id: user.id, username: user.username}
            if user.avatar.attached?
                obj["avatar"] = "#{ENV['CLOUDFRONT_API']}/#{user.avatar.key}"
            end
            obj
        end
        render json: {followers: followers}
    end
end
