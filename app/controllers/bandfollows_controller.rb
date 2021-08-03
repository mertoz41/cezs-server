class BandfollowsController < ApplicationController
    include Rails.application.routes.url_helpers

    def create
        user = User.find(params[:user_id])
        band = Band.find(params[:band_id])
        new_follow = Bandfollow.create(user_id: user.id, band_id: band.id)
        render json: {new_follow: new_follow}



    end 
    def destroy
        bandfollow = Bandfollow.find(params[:id])
        bandfollow.destroy
        render json: {message: 'success'}
    end

    def bandfollowers
        band = Band.find(params[:id])
        followers = band.followers.map do |user|
            {username: user.username, avatar: url_for(user.avatar), id: user.id}
        end
        render json: {followers: followers}
        

    end
end
