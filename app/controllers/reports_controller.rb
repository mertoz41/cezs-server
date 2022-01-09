class ReportsController < ApplicationController

    def postreport
        PostReport.create(post_id: params[:id], action_user_id: logged_in_user.id)
        render json: {message: 'post reported.'}
    end

    def commentreport
        CommentReport.create(comment_id: params[:comment_id], action_user_id: params[:action_user_id])
        render json: {message: 'comment reported.'}
    end

    def userreport
        AccountReport.create(user_id: params[:user_id], action_user_id: params[:action_user_id])
        render json: {message: 'user reported.'}
    end
    def bandreport
        AccountReport.create(band_id: params[:band_id], action_user_id: params[:action_user_id])
        render json: {message: 'band reported.'}
    end
end
