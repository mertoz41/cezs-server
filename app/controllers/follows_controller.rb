class FollowsController < ApplicationController

    def create
        following_user = User.find(logged_in_user.id)
        followed_user = User.find(params[:id])
        new_follow = Follow.create(follower_id: following_user.id, followed_id: followed_user.id)
        @new_notification = Notification.create(user_id: followed_user.id, action_user_id: logged_in_user.id, seen: false)
        ActionCable.server.broadcast "notifications_channel_#{ followed_user.id}", NotificationSerializer.new(@new_notification)

        # if followed_user.notification_token
        #     SendNotificationJob.perform_later(
        #         followed_user.notification_token.token,
        #         "#{following_user.username} is now following you.",
        #         FollowNotificationSerializer.new(@new_notification).as_json
        #     )
        # end
        render json: {message: 'is followed.'}
    end

    def destroy 
        follow = Follow.find_by(follower_id: logged_in_user.id, followed_id: params[:id])
        follow.destroy
        render json: {message: "is unfollowed."}
    end 

    def follows
        user = User.find(params[:id])
        @followed_users = user.followeds
        @followed_bands = user.followedbands
        @followed_artists = user.followedartists
        @followed_songs = user.followedsongs
        render json: {
            users: ActiveModel::Serializer::CollectionSerializer.new(@followed_users, serializer: ShortUserSerializer), 
            bands: ActiveModel::Serializer::CollectionSerializer.new(@followed_bands, serializer: ShortBandSerializer), 
            artists: ActiveModel::Serializer::CollectionSerializer.new(@followed_artists, serializer: ArtistSerializer), 
            songs: ActiveModel::Serializer::CollectionSerializer.new(@followed_songs, serializer: SongSerializer), 
        }
    end 
    def followers
        user = User.find(params[:id])
        @followed_by_users = user.followers
        render json: {followers: ActiveModel::Serializer::CollectionSerializer.new(@followed_by_users, serializer: ShortUserSerializer)}
    end

    def search_followed_users
        # out of logged_in_user.follows users pick the ones that match their usernames
        # params[:searching]
        users = logged_in_user.followeds.select{|user| user.username.include? params[:searching]}
        render json: {
            users: ActiveModel::Serializer::CollectionSerializer.new(users, serializer: ShortUserSerializer), 
    }
    end

    
end
