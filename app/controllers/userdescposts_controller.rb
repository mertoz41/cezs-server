class UserdescpostsController < ApplicationController
    def create
        user_id = params[:user_id].to_i
        description = params[:description]
        instrument_id = params[:instrument_id]
        @new_post = Userdescpost.create(user_id: user_id, description: description, instrument_id: instrument_id)
        @new_post.clip.attach(params[:clip])
        render json: @new_post, serializer: UserdescpostSerializer
    end 
end
