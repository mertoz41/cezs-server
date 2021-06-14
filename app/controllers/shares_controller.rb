class SharesController < ApplicationController
    def create
        user = User.find(params[:user_id])
        @nu_share = Share.create(user_id: user.id, post_id: params[:post_id])
        render json: @nu_share, serializer: ShareSerializer
    end

    def destroy
        share = Share.find(params[:id])
        share.destroy
        render json: {message: "Success"}
    end 
end
