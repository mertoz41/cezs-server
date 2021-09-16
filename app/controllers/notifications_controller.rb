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
        render json: {message: 'notifications seen.'}
    end

    
end
