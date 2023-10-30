class ReportCreator
    def initialize(params)
        @post_id = params[:post_id] || nil
        @comment_id = params[:comment_id] || nil
        @user_id = params[:user_id] || nil
        @band_id = params[:band_id] || nil
        @event_id = params[:event_id] || nil
        @description = params[:description]
        @reporting_user_id = params[:reporting_user_id]
    end

    def create!
        create_report
    end

    private

    def create_report
        Report.create(
        post_id: @post_id, 
        comment_id: @comment_id, 
        user_id: @user_id, 
        band_id: @band_id, 
        event_id: @event_id, 
        description: @description, 
        reporting_user_id: @reporting_user_id,
        resolved: false
        )
    end
end