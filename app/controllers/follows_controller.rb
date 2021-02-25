class FollowsController < ApplicationController
    def create 
        new_follow = Follow.create(follower_id: params[:followerId], followed_id: params[:followedId])
        render json: {follow: new_follow}
    end 
    def destroy
        follow = Follow.find(params[:id])
        follow.destroy
        render json: {message: "success"}
    end 
end
