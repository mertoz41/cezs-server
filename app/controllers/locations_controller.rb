class LocationsController < ApplicationController
    def index
        @locations = Location.all
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer)}
        # how can all locations except current users be shown so that loggedin users location isnt filtered out post process.
    end
    def show
        @users = Location.find(params[:id]).users
        @bands = Location.find(params[:id]).bands
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: UserSerializer), bands: ActiveModel::Serializer::CollectionSerializer.new(@bands, each_serializer: BandSerializer)}
    end
    def create
        # incoming location to be checked whether it exists
        # if it exists, create Userlocation model with that locations id and users id
        # if it doesnt exist, create location, then create userlocation model with locations id and user id.

        @user = User.find(params[:user_id])

       
        # if @user.location.users.size == 1
        location = Location.find_by(city: params[:city])
        if location
            # if location exists
            user_location = Userlocation.create(user_id: @user.id, location_id: location.id)
        else
            new_location = Location.create(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
            new_user_location = Userlocation.create(user_id: @user.id, location_id: new_location.id)
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
        user_location = Userlocation.find_by(user_id: @user.id)
        location = Location.find_by(city: params[:city])
        if location
            # if location exists 
            user_location.update(location_id: location.id)
           
            # user_location = Userlocation.create(user_id: @user.id, location_id: location.id)
        else
            new_location = Location.create(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
            user_location.update(location_id: new_location.id)

            # if its a new location create location first
            # then create user_location
        end

        if old_location.users.length == 0
            # delete location if there are no users
            old_location.destroy
        end
      
        render json: {user: UserSerializer.new(@user)}
    end 

    def filterlocations
        locations = Location.all
        states = []
        locations.each do |location|
            if !states.include?(location.city.split()[1])
                states.push(location.city.split()[1])
            end
        end
        render json: {states: states}
        # action to get all existing states in db
    end
end
