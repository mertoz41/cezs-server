class BandsController < ApplicationController

    def searching
        all_bands = Band.where("name like?", "%#{params[:searching]}%")
        @bands = all_bands.select {|band| !band_blokes.include?(band.id)}
        render json: {bands: ActiveModel::Serializer::CollectionSerializer.new(@bands, each_serializer: BandSerializer)}
    end
    def picture
        @band = Band.find(params[:band_id])
        @band.picture.attach(params[:picture])
        render json: {band: BandSerializer.new(@band)}
    end

    def bandposts
        band = Band.find(params[:id])
        @posts = band.posts
        render json: @posts, each_serializer: PostSerializer
    end

    def show
        band = Band.find(params[:id])
        follows = logged_in_user.bandfollows.find_by(band_id: band.id) ? true : false
        render json: {band: BandSerializer.new(band), follows: follows}
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
    
    def update
        @band = Band.find(params[:id])
        if params[:name]
            @band.update_column 'name', params[:name]
        end
        if params[:bio]
            @band.update_column 'bio', params[:bio]
        end
        if params[:location]
            location = Location.find_or_create_by(city: params[:location]["city"], latitude: params[:location]["latitude"], longitude: params[:location]["longitude"])
            band_location = Bandlocation.find_by(band_id: @band.id, location_id: @band.location.id)
            band_location.update(location_id: location.id)
        end
        if params[:members]
            params[:members].each do |member|
                Bandmember.create({user_id: member, band_id: @band.id})
            end
        end
        if params[:removedMembers]
            params[:removedMembers].each do |member|
            instance = Bandmember.find_by(user_id: member, band_id: @band.id)
            instance.destroy
            end
        end
        render json: {band: BandSerializer.new(@band)}
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
