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
        render json: {picture: "#{ENV['CLOUDFRONT_API']}#{@band.picture.key}"}
    end



    def show
        band = Band.find(params[:id])
        follows = logged_in_user.bandfollows.find_by(band_id: band.id) ? true : false
        render json: {band: BandSerializer.new(band), follows: follows}
    end
    
    def create
        @band = Band.create(name: params[:name], bio: params[:bio])
        @band.picture.attach(params[:picture])
        members = JSON.parse params[:members]
        members.each do |id|
            Bandmember.create(user_id: id, band_id: @band.id)
        end
        genres = JSON.parse params[:genres]
        genres.each do |genre|
            found_genre = Genre.find_or_create_by(name: genre)
            Bandgenre.create(band_id: @band.id, genre_id: found_genre.id)
        end
        filtered_members = members.select {|id| id != params[:user_id].to_i}
        filtered_members.each do |id|
            @notification = Notification.create(band_id: @band.id, action_user_id: params[:user_id], seen: false, user_id: id)
            ActionCable.server.broadcast "notifications_channel_#{id}", NotificationSerializer.new(@notification)
        end

        location = Location.find(params[:location_id])
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
        if params[:picture]
            @band.picture.purge
            @band.picture.attach(params[:picture])
        end
        if params[:locationLatitude]
            location = Location.find_or_create_by(city: params[:city], latitude: params[:locationLatitude], longitude: params[:locationLongitude])
            band_location = Bandlocation.find_by(band_id: @band.id, location_id: @band.location.id)
            band_location.update(location_id: location.id)
        end
        if params[:genres]
            params[:genres].each do |genre|
                found_genre = Genre.find_or_create_by(name: genre)
                Bandgenre.create(genre_id: found_genre.id, band_id: @band.id)
            end
        end
        if params[:members]
            params[:members].each do |member|
                Bandmember.create({user_id: member.to_i, band_id: @band.id})
            end
        end
        if params[:removedMembers]
            params[:removedMembers].each do |member|
            instance = Bandmember.find_by(user_id: member.to_i, band_id: @band.id)
            instance.destroy
            end
        end
        if params[:removedGenres]
            params[:removedGenres].each do |genre|
                instance = Bandgenre.find_by(genre_id: genre.to_i, band_id: @band.id)
                instance.destroy
            end
        end
        render json: {band: BandSerializer.new(@band)}
    end

    def destroy
        band = Band.find(params[:id])
        band.destroy
        render json: {message: 'band deleted.'}
    end

    def filter_search
        instrument_users = User.joins(:instruments).merge(Instrument.where(id: params[:instruments]))
        bands = []
        instrument_bands = instrument_users.each do |user|
            bands = bands + user.bands
        end
        genre_bands = Band.joins(:genres).merge(Genre.where(id: params[:genres]))
        @bands = filter_blocked_bands(bands + genre_bands)
        filtered_bands = []
        if logged_in_user.blocked_bands.size
            filtered_bands = filter_blocked_bands(bands + genre_bands)
        else
            filtered_bands = bands + genre_bands
        end
        filtered_bands = filtered_bands.select{|band| band.reports.size < 1}
        
        render json: filtered_bands.uniq, each_serializer: ShortBandSerializer
    end
end
