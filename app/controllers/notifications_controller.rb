class NotificationsController < ApplicationController
    def marknotifications
        params[:notifications].each do |noti|
            notification = Notification.find(noti)
            notification.update(seen: true)
        end
        render json: {message: 'notifications seen.'}
    end
end
