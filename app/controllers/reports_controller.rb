class ReportsController < ApplicationController
    def post_report
        Report.create(post_id: params[:post_id], description: params[:description] reporting_user_id: logged_in_user.id)
        render json: {message: 'post reported.'}
    end

    def comment_report
        Report.create(comment_id: params[:comment_id], description: params[:description] reporting_user_id: logged_in_user.id)
        render json: {message: 'comment reported.'}
    end

    def user_report
        Report.create(user_id: params[:user_id], description: params[:description] reporting_user_id: logged_in_user.id)
        render json: {message: 'user reported.'}
    end
    def band_report
        Report.create(band_id: params[:band_id], description: params[:description] reporting_user_id: logged_in_user.id)
        render json: {message: 'band reported.'}
    end
    def event_report
        Report.create(event_id: params[:event_id], description: params[:description] reporting_user_id: logged_in_user.id)
        render json: {message: 'event reported.'}
    end
end
