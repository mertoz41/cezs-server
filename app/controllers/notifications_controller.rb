class NotificationsController < ApplicationController
    def marknotifications
        params[:notifications].each do |noti|
            notification = Notification.find(noti)
            notification.update(seen: true)
        end
        # params[:follows].each do |follow|
        #     follw = FollowNotification.find(follow)
        #     follw.update(seen: true)
        # end
    
        # params[:events].each do |event|
        #     evnt = EventNotification.find(event)
        #     evnt.update(seen: true)
        # end
        # params[:auditions].each do |audit|
        #     audition = AuditionNotification.find(audit)
        #     audition.update(seen: true)
        # end
        # params[:applauds].each do |appld|
        #     applaud = ApplaudNotification.find(appld)
        #     applaud.update(seen: true)
        render json: {message: 'notifications seen.'}
    end

    def seecommentnoti
        noti = CommentNotification.find(params[:id])
        @post = noti.post
        noti.update(seen: true)
        render json: @post, serializer: PostSerializer
    end

    def seeapplaudnoti
        noti = ApplaudNotification.find(params[:id])
        @post = noti.applaud.post
        noti.update(seen: true)
        render json: @post, serializer: PostSerializer
    end

    def seegignoti
        event_noti = EventNotification.find(params[:id])
        event_noti.update(seen: true)
    end

    def seefollownoti
        noti = FollowNotification.find(params[:id])
        noti.update(seen: true)
    end

    def seeauditnoti
        event_noti = AuditionNotification.find(params[:id])
        event_noti.update(seen: true)
    end

end
