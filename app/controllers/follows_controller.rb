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

    def follows
        user = User.find(params[:id])
        @followed_users = []
        user.follows.each do |follow|
            searched_user = User.find(follow.followed_id)
            @followed_users.push(searched_user)
        end 
        render json: {follows: ActiveModel::Serializer::CollectionSerializer.new(@followed_users, each_serializer: UserSerializer)}

        # render json: {follows: ActiveModel::Serializer::CollectionSerializer.new(@follows, each_serializer: FollowSerializer)}
    end 
    def followers
        user = User.find(params[:id])
        @followed_by_users = []
        user.followed_by.each do |follow|
            searched_user = User.find(follow.follower_id)
            @followed_by_users.push(searched_user)
        end
        render json: {followers: ActiveModel::Serializer::CollectionSerializer.new(@followed_by_users, each_serializer: UserSerializer)}
    end
end
