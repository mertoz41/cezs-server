class BandfollowsController < ApplicationController
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
end
