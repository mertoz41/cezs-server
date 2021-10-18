class NotificationsController < ApplicationController
    def marknotifications
        params[:comments].each do |comment|
            commnt = CommentNotification.find(comment)
            commnt.update(seen: true)
        end
        params[:follows].each do |follow|
            follw = FollowNotification.find(follow)
            follw.update(seen: true)
        end
        params[:shares].each do |share|
            shre = ShareNotification.find(share)
            shre.update(seen: true)
        end
        params[:events].each do |event|
            evnt = EventNotification.find(event)
            evnt.update(seen: true)
        end
        params[:auditions].each do |audit|
            audition = AuditionNotification.find(audit)
            audition.update(seen: true)
        end
        render json: {message: 'notifications seen.'}
    end
end
