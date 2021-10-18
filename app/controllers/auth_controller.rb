class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            @timeline = @user.timeline
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
            
            render json: {
                user: UserSerializer.new(@user), 
                token: token, 
                timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer),
                event_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_events, each_serializer: EventNotificationSerializer),
                share_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.share_notifications, each_serializer: ShareNotificationSerializer),
                comment_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.comment_notifications, each_serializer: CommentNotificationSerializer),
                follow_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.follow_notifications, each_serializer: FollowNotificationSerializer),
                audition_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_auditions, each_serializer: AuditionNotificationSerializer)
            }
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        token = request.headers["Authorization"].split(' ')[1]
        @user = User.find(decode(token)["user_id"])
        @timeline = @user.timeline
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
        # all notifications
        render json: {
            user: UserSerializer.new(@user), 
            timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer),
            event_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_events, each_serializer: EventNotificationSerializer),
            share_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.share_notifications, each_serializer: ShareNotificationSerializer),
            comment_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.comment_notifications, each_serializer: CommentNotificationSerializer),
            follow_notifications: ActiveModel::Serializer::CollectionSerializer.new(@user.follow_notifications, each_serializer: FollowNotificationSerializer),
            audition_notifications: ActiveModel::Serializer::CollectionSerializer.new(@filtered_auditions, each_serializer: AuditionNotificationSerializer)
        }
    end

end
