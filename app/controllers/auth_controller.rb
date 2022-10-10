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
            # .select {|post| !blokes.include?(post.user_id)}.select{|post| !band_blokes.include?(post.band_id)}
            
            @filtered_events = @user.event_notifications.joins(:event).where('event_date >= ?', Date.today)
            render json: {
                user: UserSerializer.new(@user), 
                token: token, 
                timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer),
                chatrooms: ActiveModel::Serializer::CollectionSerializer.new(@chatrooms, each_serializer: ChatroomSerializer),
                event_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_events, each_serializer: EventNotificationSerializer),
                comment_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.comment_notifications, each_serializer: CommentNotificationSerializer),
                follow_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.follow_notifications, each_serializer: FollowNotificationSerializer),
                applaud_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.applaud_notifications, each_serializer: ApplaudNotificationSerializer),
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
        
        @chatrooms = @user.chatrooms
        @timeline = timeline_info[:timeline]
        @filtered_events = @user.event_notifications.joins(:event).where('event_date >= ?', Date.today)
        # all notifications
        render json: {
            user: UserSerializer.new(@user), 
            timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer),
            event_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_events, each_serializer: EventNotificationSerializer),
            comment_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.comment_notifications, each_serializer: CommentNotificationSerializer),
            follow_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.follow_notifications, each_serializer: FollowNotificationSerializer),                
            applaud_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.applaud_notifications, each_serializer: ApplaudNotificationSerializer),
            chatrooms: ActiveModel::Serializer::CollectionSerializer.new(@chatrooms, each_serializer: ChatroomSerializer),
            band_posts: timeline_info[:bandposts], 
            user_posts: timeline_info[:userposts], 
            artist_posts: timeline_info[:artistposts], 
            album_posts: timeline_info[:albumposts],
            song_posts: timeline_info[:songposts]
        }
    end

end
