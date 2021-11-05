class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            timeline_info = @user.timeline
            @chatrooms = @user.chatrooms
            @timeline = timeline_info[:timeline]
            @filtered_events = []
            @filtered_auditions = []
            @playlists = @user.playlists
            @user.event_notifications.each do |noti|
                event = Event.find(noti.event_id)
                if event.event_date < Date.today
                    EventNotification.find(noti.id).destroy
                else
                    @filtered_events.push(noti)
                end
            end
            @user.audition_notifications.each do |noti|
                audition = Audition.find(noti.audition_id)
                if audition.audition_date < Date.today
                    AuditionNotification.find(noti.id).destroy
                else
                    @filtered_auditions.push(noti)
                end
            end

            
            
            render json: {
                user: UserSerializer.new(@user), 
                token: token, 
                timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer),
                chatrooms: ActiveModel::Serializer::CollectionSerializer.new(@chatrooms, each_serializer: ChatroomSerializer),
                event_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_events, each_serializer: EventNotificationSerializer),
                comment_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.comment_notifications, each_serializer: CommentNotificationSerializer),
                follow_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.follow_notifications, each_serializer: FollowNotificationSerializer),
                audition_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_auditions, each_serializer: AuditionNotificationSerializer),
                applaud_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.applaud_notifications, each_serializer: ApplaudNotificationSerializer),
                playlist_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.playlist_notifications, each_serializer: PlaylistNotificationSerializer),
                playlists: ActiveModel::Serializer::CollectionSerializer.new(@playlists, each_serializer: PlaylistSerializer),
                band_posts: timeline_info[:bandposts], 
                user_posts: timeline_info[:userposts], 
                artist_posts: timeline_info[:artistposts], 
                album_posts: timeline_info[:albumposts],
                song_posts: timeline_info[:songposts]
                }
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        token = request.headers["Authorization"].split(' ')[1]
        @user = User.find(decode(token)["user_id"])
        timeline_info = @user.timeline
        @playlists = @user.playlists
        @chatrooms = @user.chatrooms

        @timeline = timeline_info[:timeline]
        @filtered_events = []
        @filtered_auditions = []
            @user.event_notifications.each do |noti|
                event = Event.find(noti.event_id)
                if event.event_date < Date.today
                    EventNotification.find(noti.id).destroy
                else
                    @filtered_events.push(noti)
                end
            end
            @user.audition_notifications.each do |noti|
                audition = Audition.find(noti.audition_id)
                if audition.audition_date < Date.today
                    AuditionNotification.find(noti.id).destroy
                else
                    @filtered_auditions.push(noti)
                end
            end
            # byebug

        # all notifications
        render json: {
            user: UserSerializer.new(@user), 
            timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer),
            event_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_events, each_serializer: EventNotificationSerializer),
            comment_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.comment_notifications, each_serializer: CommentNotificationSerializer),
            follow_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.follow_notifications, each_serializer: FollowNotificationSerializer),                
            applaud_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.applaud_notifications, each_serializer: ApplaudNotificationSerializer),
            playlist_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.playlist_notifications, each_serializer: PlaylistNotificationSerializer),
            audition_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_auditions, each_serializer: AuditionNotificationSerializer),
            playlists: ActiveModel::Serializer::CollectionSerializer.new(@playlists, each_serializer: PlaylistSerializer),
            chatrooms: ActiveModel::Serializer::CollectionSerializer.new(@chatrooms, each_serializer: ChatroomSerializer),
            band_posts: timeline_info[:bandposts], 
            user_posts: timeline_info[:userposts], 
            artist_posts: timeline_info[:artistposts], 
            album_posts: timeline_info[:albumposts],
            song_posts: timeline_info[:songposts]
        }
    end

end
