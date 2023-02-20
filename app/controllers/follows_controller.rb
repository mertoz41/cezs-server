class FollowsController < ApplicationController

    def follow
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

    def unfollow
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
            users: ActiveModel::Serializer::CollectionSerializer.new(@followed_users, each_serializer: UserSerializer), 
            bands: ActiveModel::Serializer::CollectionSerializer.new(@followed_bands, each_serializer: BandSerializer), 
            artists: ActiveModel::Serializer::CollectionSerializer.new(@followed_artists, each_serializer: ArtistSerializer), 
            songs: ActiveModel::Serializer::CollectionSerializer.new(@followed_songs, each_serializer: SongSerializer), 
        }
        # render json: {follows: ActiveModel::Serializer::CollectionSerializer.new(@follows, each_serializer: FollowSerializer)}
    end 
    def followers
        user = User.find(params[:id])
        @followed_by_users = user.followers
        render json: {followers: ActiveModel::Serializer::CollectionSerializer.new(@followed_by_users, each_serializer: ShortUserSerializer)}
    end

    
end
