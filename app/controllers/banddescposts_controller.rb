class BanddescpostsController < ApplicationController
    def create
        band_id = params[:band_id].to_i
        description = params[:description]
        @new_post = Banddescpost.create(band_id: band_id, description: description)
        @new_post.clip.attach(params[:clip])
        render json: @new_post, serializer: BanddescpostSerializer
    end 
end
