class LocationsController < ApplicationController
    def index
        @locations = Location.all
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer)}
        # how can all locations except current users be shown so that loggedin users location isnt filtered out post process.
    end
    def show
        @users = Location.find(params[:id]).users
        # @users_with_bands = @users.map do |user|
        #     nu_user = user.attributes
        #     nu_user["bands"] = user.bands
        #     return nu_user
        # end 
        # byebug
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: UserSerializer)}
    end
    def create
        # incoming location to be checked whether it exists
        # if it exists, create Userlocation model with that locations id and users id
        # if it doesnt exist, create location, then create userlocation model with locations id and user id.

        @user = User.find(params[:user_id])
        location = Location.find_or_create_by(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
        user_location = Userlocation.create(user_id: @user.id, location_id: location.id)
        @locations = Location.all
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer), user: UserSerializer.new(@user)}
    end 

    def update
        # need to find or create location by city and latitude and longitude.
        # need to update Userlocation model. 
        # find userlocation by user_id
        @user = User.find(params[:user_id])
        location = Location.find_or_create_by(city: params[:regionName], latitude: params[:latitude], longitude: params[:longitude])
        user_location = Userlocation.find_by(user_id: @user.id)
        user_location.update(location_id: location.id)
        render json: {user: UserSerializer.new(@user)}
    end 
end
