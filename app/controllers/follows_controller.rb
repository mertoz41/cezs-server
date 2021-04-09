class FollowsController < ApplicationController
    def create 
        new_follow = Follow.create(follower_id: params[:followerId], followed_id: params[:followedId])
        render json: {follow: new_follow}
    end 
    def destroy
        follow = Follow.find(params[:id])
        follow.destroy
        render json: {message: "succezs"}
    end 

    def follows
        user = User.find(params[:id])
        @followed_users = user.followeds
        @followed_bands = user.followedbands
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@followed_users, each_serializer: UserSerializer), bands: ActiveModel::Serializer::CollectionSerializer.new(@followed_bands, each_serializer: BandSerializer)}

        # render json: {follows: ActiveModel::Serializer::CollectionSerializer.new(@follows, each_serializer: FollowSerializer)}
    end 
    def followers
        user = User.find(params[:id])
        @followed_by_users = user.followers
        render json: {followers: ActiveModel::Serializer::CollectionSerializer.new(@followed_by_users, each_serializer: UserSerializer)}
    end
end
