class BandlocationsController < ApplicationController

    def update
        @band = Band.find(params[:band_id])
        location = Location.find_or_create_by(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
        byebug
        # band_location = Bandlocation.find_by(band_id: @band.id)
        # band_location.update(location_id: location.id)
        # render json: {band: BandSerializer.new(@band)}
    end
end
