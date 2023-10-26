class ApplaudsController < ApplicationController
    def create
        applaud = Applaud.create(post_id: params[:post_id], user_id: logged_in_user.id)
        applaud.send_notifications(logged_in_user.id)
        render json: {message: 'post applauded.'}
    end

    def destroy
        applaud = Applaud.find_by(user_id: logged_in_user.id, post_id: params[:id])
        applaud.destroy
        render json: {message: 'post unapplauded.'}
    end
end
