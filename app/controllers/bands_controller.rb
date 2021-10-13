class BandsController < ApplicationController

    def searching
        @bands = Band.where("name like?", "%#{params[:searching]}%")
        render json: {bands: ActiveModel::Serializer::CollectionSerializer.new(@bands, each_serializer: BandSerializer)}
    end
    def picture
        @band = Band.find(params[:band_id])
        @band.picture.attach(params[:picture])
        render json: {band: BandSerializer.new(@band)}
    end

    def show
        @band = Band.find(params[:id])
        render json: {band: BandSerializer.new(@band)}
    end
    
    def create
        # create the band first with name description and picture

        @band = Band.create(name: params[:name])
        bio = Bandbio.create(description: params[:description], band_id: @band.id)
        @band.picture.attach(params[:picture])
        
        # create bandmember instance for each user
        members = JSON.parse params[:members]
        # byebug
        members.each do |id|
            Bandmember.create(user_id: id, band_id: @band.id)
        end

        # find location object
        location = Location.find(params[:location_id])

        # create bandlocation object
        Bandlocation.create(band_id: @band.id, location_id: location.id)

        render json: @band, serializer: BandSerializer

    end
    def filtersearch
        instrument_users = User.joins(:instruments).merge(Instrument.where(id: params[:instruments]))
        bands = []
        instrument_bands = instrument_users.each do |user|
            bands = bands + user.bands
        end
        genre_bands = Band.joins(:genres).merge(Genre.where(id: params[:genres]))
        @bands = bands + genre_bands
        
        render json: @bands.uniq, each_serializer: ShortBandSerializer
    end
end
