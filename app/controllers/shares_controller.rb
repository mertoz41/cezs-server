class SharesController < ApplicationController
    def create      
        @nu_share = Share.create(user_id: params[:user_id].to_i, post_id: params[:post_id])
        render json: @nu_share, serializer: ShareSerializer
    end

    def destroy
        share = Share.find(params[:id])
        share.destroy
        render json: {message: "Success"}
    end 
end
