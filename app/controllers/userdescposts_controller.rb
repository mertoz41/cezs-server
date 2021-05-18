class UserdescpostsController < ApplicationController
    def create
        user_id = params[:user_id].to_i
        description = params[:description]
        instrument_id = params[:instrument_id]
        @new_post = Userdescpost.create(user_id: user_id, description: description, instrument_id: instrument_id, thumbnail: params[:thumbnail], genre_id: genre_id)
        @new_post.clip.attach(params[:clip])
        render json: @new_post, serializer: UserdescpostSerializer
    end 

    def share
        userdescpost = Userdescpost.find(params[:userdescpost_id])
        user = User.find(params[:user_id])
        @nu_share = Userdescpostshare.create(user_id: user.id, userdescpost_id: userdescpost.id)
        render json: {nu_share: UserdescpostshareSerializer.new(@nu_share)}
    end
    def unshare
        share = Userdescpostshare.find(params[:id])
        share.destroy
        render json: {message: 'post unshared.'}
    end
    def destroy
        userdescpost = Userdescpost.find(params[:id])
        userdescpost.destroy
        render json: {message: 'userdescpost deleted.'}
    end
end
