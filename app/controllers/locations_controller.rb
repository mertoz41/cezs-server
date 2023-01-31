class LocationsController < ApplicationController
    def index
        @locations = Location.all
        events_number = Event.where('event_date >= ?', Date.today).size
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer), users_number: User.all.size, events_number: events_number}
        # how can all locations except current users be shown so that loggedin users location isnt filtered out post process.
    end
    def show
        @all_users = Location.find(params[:id]).users
        @all_bands = Location.find(params[:id]).bands
        if logged_in_user.blocked_users.size || logged_in_user.blocked_bands.size || logged_in_user.blocking_users.size
            @all_users = filter_blocked_users(@all_users)
            @all_bands = filter_blocked_bands(@all_bands)
        else 
            @all_users = @all_users
            @all_bands = @all_bands
        end
        
        render json:
        #  @all_users, each_serializer: ShortUserSerializer
        {
            users: ActiveModelSerializers::SerializableResource.new(@all_users, each_serializer: ShortUserSerializer), 
            bands: ActiveModelSerializers::SerializableResource.new(@all_bands, each_serializer: ShortBandSerializer)
        }
    end
    def create
        # incoming location to be checked whether it exists
        # if it exists, create Userlocation model with that locations id and users id
        # if it doesnt exist, create location, then create userlocation model with locations id and user id.
    
        # if @user.location.users.size == 1
        location = Location.find_by(city: params[:city])
        if location
            # if location exists
            user_location = Userlocation.create(user_id: logged_in_user.id, location_id: location.id)
        else
            new_location = Location.create(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
            new_user_location = Userlocation.create(user_id: logged_in_user.id, location_id: new_location.id)
            # if its a new location create location first
            # then create user_location
        end

       

        # find or create by city only

        # check that users last location to see if another user exists in that location
        @locations = Location.all
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer), user: UserSerializer.new(@user)}
    end 

    def update
        # need to find or create location by city and latitude and longitude.
        # need to update Userlocation model. 
        # find userlocation by user_id
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

    # def filterlocations
    #     locations = Location.all
    #     states = []
    #     locations.each do |location|
    #         location.users.each do |user|
    #             if user.posts.size > 0 || user.userdescposts.size > 0 && !states.include?(location.city)
    #                 states.push(location.city)
    #             end
    #         end
    #         # location.bands.each do |band|
    #         #     if !states.include?(location.city) && band.bandposts.size > 0 || band.banddescposts.size > 0 
    #         #         states.push(location.city)
    #         #     end
    #         # end
    #     end
    #         # if !states.include?(location.city) && location.posts.size > 0 || location.bandposts
    #         # end
        
    #     render json: {states: states}
    #     # action to get all existing states in db
    # end
end
