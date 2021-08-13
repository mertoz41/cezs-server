class UserdescpostsController < ApplicationController
    def create
        user_id = params[:user_id].to_i
        description = params[:description]
        features = JSON.parse params[:features]
        instruments = JSON.parse params[:instruments]
        genre = Genre.find_or_create_by(name: params[:genre])

        @new_post = Userdescpost.create(user_id: user_id, description: description, genre_id: genre.id)
        if features.length > 0
            features.each do |id|
                Userdescpostfeature.create(user_id: id, userdescpost_id: @new_post.id)
            end
        end
        
        instruments.each do |instrument|
            inst = Instrument.find_or_create_by(name: instrument)
            Userdescpostinstrument.create(instrument_id: inst.id, userdescpost_id: @new_post.id)
        end

        @new_post.clip.attach(params[:clip])
        @new_post.thumbnail.attach(params[:thumbnail])
        render json: @new_post, serializer: UserdescpostSerializer
    end
    
    


    def createview
        user = User.find(params[:user_id])
        post = Userdescpost.find(params[:userdescpost_id])
        Userdescpostview.create(user_id: user.id, userdescpost_id: post.id)
        render json: {message: 'view counted'}
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
