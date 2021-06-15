class UserdescpostsController < ApplicationController
    def create
        user_id = params[:user_id].to_i
        genre_id = params[:genre_id].to_i
        description = params[:description]
        features = JSON.parse params[:features]
        instruments = JSON.parse params[:instruments]
        @new_post = Userdescpost.create(user_id: user_id, description: description, thumbnail: params[:thumbnail], genre_id: genre_id)
        if features.length > 0
            features.each do |id|
                Userdescpostfeature.create(user_id: id, userdescpost_id: @new_post.id)
            end
        end
        if instruments.length > 0
            instruments.each do |id|
                Userdescpostinstrument.create(instrument_id: id, userdescpost_id: @new_post.id)
            end
        end
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
