class LocationsController < ApplicationController
    def index
        @locations = Location.all
        events_number = Event.where('event_date >= ?', Date.today).size

        render json: {
            locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer), 
            users_number: User.all.size, 
            events_number: events_number,
        }
    end
    def show
        @all_users = Location.find(params[:id]).users.select {|user| user.reports.size < 1}
        @all_bands = Location.find(params[:id]).bands.select {|band| band.reports.size < 1}
        if logged_in_user.blocked_users.size || logged_in_user.blocked_bands.size || logged_in_user.blocking_users.size
            @all_users = filter_blocked_users(@all_users)
            @all_bands = filter_blocked_bands(@all_bands)
        else 
            @all_users = @all_users
            @all_bands = @all_bands
        end
        render json:
        {
            users: ActiveModelSerializers::SerializableResource.new(@all_users, each_serializer: ShortUserSerializer), 
            bands: ActiveModelSerializers::SerializableResource.new(@all_bands, each_serializer: ShortBandSerializer)
        }
    end
    def create
        location = Location.find_by(city: params[:city])
        if location
            # if location exists
            user_location = Userlocation.create(user_id: logged_in_user.id, location_id: location.id)
        else
            new_location = Location.create(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
            new_user_location = Userlocation.create(user_id: logged_in_user.id, location_id: new_location.id)

        end

        @locations = Location.all
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer), user: UserSerializer.new(@user)}
    end 
    def update
        @user = User.find(params[:user_id])
        old_location = @user.location
        user_location = Userlocation.find_by(user_id: @user.id, location_id: old_location.id)
        location = Location.find_by(city: params[:city])
        
        if location
            user_location.update(location_id: location.id)
            render json: {location: location}
        else
            new_location = Location.create(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
            user_location.update(location_id: new_location.id)
            render json: {location: new_location}
        end
    end 
end
