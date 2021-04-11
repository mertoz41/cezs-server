class ArtistfollowsController < ApplicationController
    def create
        new_follow = Artistfollow.create(user_id: params[:user_id], artist_id: params[:artist_id]) 
        render json: {new_follow: new_follow}
    end 

    def destroy
        artis_follow = Artistfollow.find_by(user_id: params[:user_id], artist_id: params[:artist_id])
        artis_follow.destroy
        render json: {message: 'succezs'}

    end
end
