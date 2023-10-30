class BandsController < ApplicationController
    include Rails.application.routes.url_helpers

    def searching
        all_bands = Band.where("name like?", "%#{params[:searching]}%")
        bands = []
        if logged_in_user.blocked_bands.size
            bands = filter_blocked_bands(all_bands)
        else
            bands = all_bands
        end
        bands = bands.select {|band| band.reports.size < 1}
        render json: {bands: ActiveModel::Serializer::CollectionSerializer.new(bands, each_serializer: BandSerializer)}
    end

    def picture
        @band = Band.find(params[:band_id])
        @band.picture.attach(params[:picture])
        render json: {picture: "#{ENV['CLOUDFRONT_API']}/#{@band.picture.key}"}
    end



    def show
        band = Band.find(params[:id])
        follows = logged_in_user.bandfollows.find_by(band_id: band.id) ? true : false
        render json: {band: BandSerializer.new(band), follows: follows}
    end
    
    def create
        @band = Band.create(name: params[:name], bio: params[:bio])
        @band.complete_band_setup(
            params[:picture], 
            params[:members],
            params[:genres],
            params[:location_id])
        render json: @band, serializer: BandSerializer
    end
    
    def update
        @band = Band.find(params[:id])
        @band.update_band(params)
        render json: {band: BandSerializer.new(@band)}
    end

    def destroy
        band = Band.find(params[:id])
        band.destroy
        render json: {message: 'band deleted.'}
    end

end
