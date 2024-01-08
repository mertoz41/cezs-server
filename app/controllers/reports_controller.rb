class ReportsController < ApplicationController
    def create
        CreateReportJob.perform_later({
            description: params[:description], 
            "#{params[:type]}_id": params[:id], 
            reporting_user_id: logged_in_user.id
        })
        render json: {message: "#{params[:type].capitalize} reported."}
    end
end
