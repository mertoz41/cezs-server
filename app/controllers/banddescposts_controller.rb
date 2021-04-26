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
end
