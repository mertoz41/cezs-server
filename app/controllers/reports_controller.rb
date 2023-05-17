class ReportsController < ApplicationController
    def post_report
        Report.create(post_id: params[:id], description: params[:description], reporting_user_id: logged_in_user.id, resolved: false)
        render json: {message: 'post reported.'}
    end

    def comment_report
        Report.create(comment_id: params[:id], description: params[:description], reporting_user_id: logged_in_user.id, resolved: false)
        render json: {message: 'comment reported.'}
    end

    def user_report
        Report.create(user_id: params[:id], description: params[:description], reporting_user_id: logged_in_user.id, resolved: false)
        render json: {message: 'user reported.'}
    end
    def band_report
        Report.create(band_id: params[:id], description: params[:description], reporting_user_id: logged_in_user.id, resolved: false)
        render json: {message: 'band reported.'}
    end
    def event_report
        Report.create(event_id: params[:id], description: params[:description], reporting_user_id: logged_in_user.id, resolved: false)
        render json: {message: 'event reported.'}
    end
end
