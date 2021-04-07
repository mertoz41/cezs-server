class BandbiosController < ApplicationController
    def update
        @band = Band.find(params[:band_id])
        bandbio = @band.bandbio
        bandbio.update(description: params[:description])
        render json: {band: BandSerializer.new(@band)}
    end
end
