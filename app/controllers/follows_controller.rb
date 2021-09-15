class FollowsController < ApplicationController
    def create
        following_user = User.find(params[:followerId])
        followed_user = User.find(params[:followedId])
        new_follow = Follow.create(follower_id: following_user.id, followed_id: followed_user.id)
        new_notification = FollowNotification.create(user_id: followed_user.id, action_user_id: following_user.id, seen: false)
        
        if followed_user.notification_token
            client = Exponent::Push::Client.new
            messages = [{
                to: followed_user.notification_token.token,
                body: "#{following_user.username} follows you."
            }]
            handler = client.send_messages(messages)
        end
        render json: {message: 'is followed.'}
    end
    def unfollow
        follow = Follow.find_by(follower_id: params[:unfollower_id], followed_id: params[:unfollowed_id])
        follow.destroy
        render json: {message: "is unfollowed."}
    end 

    def follows
        user = User.find(params[:id])
        @followed_users = user.followeds
        @followed_bands = user.followedbands
        @followed_artists = user.followedartists
        @followed_songs = user.followedsongs
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@followed_users, each_serializer: UserSerializer), bands: ActiveModel::Serializer::CollectionSerializer.new(@followed_bands, each_serializer: BandSerializer), artists: ActiveModel::Serializer::CollectionSerializer.new(@followed_artists, each_serializer: ArtistSerializer), songs: ActiveModel::Serializer::CollectionSerializer.new(@followed_songs, each_serializer: SongSerializer)}
        # render json: {follows: ActiveModel::Serializer::CollectionSerializer.new(@follows, each_serializer: FollowSerializer)}
    end 
    def followers
        user = User.find(params[:id])
        @followed_by_users = user.followers
        render json: {followers: ActiveModel::Serializer::CollectionSerializer.new(@followed_by_users, each_serializer: UserSerializer)}
    end
end
