class BanddescpostsController < ApplicationController
    def create
        band_id = params[:band_id].to_i
        description = params[:description]
        instruments = JSON.parse params[:instruments]
        @new_post = Banddescpost.create(band_id: band_id, description: description)
        instruments.each do |inst|
            Banddescpostinstrument.create(instrument_id: inst, banddescpost_id: @new_post.id)
        end
        @new_post.clip.attach(params[:clip])
        render json: @new_post, serializer: BanddescpostSerializer
    end 

    def share
        post = Banddescpost.find(params[:banddescpost_id])
        user = User.find(params[:user_id])
        @nu_share = Banddescpostshare.create(banddescpost_id: post.id, user_id: user.id)
        render json: {nu_share: BanddescpostshareSerializer.new(@nu_share)}
        # byebug
        # findbanddescpost and user
        # create instance
    end

    def unshare
        share = Banddescpostshare.find(params[:id])
        share.destroy
        render json: {message: 'post unshared.'}
    end
end
