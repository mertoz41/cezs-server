class LocationsController < ApplicationController
    def index
        locations = Location.all
        render json: {locations: locations}
        # how can all locations except current users be shown so that loggedin users location isnt filtered out post process.
    end 
    def create
        # incoming location to be checked whether it exists
        # if it exists, create Userlocation model with that locations id and users id
        # if it doesnt exist, create location, then create userlocation model with locations id and user id.

        @user = User.find(params[:user_id])
        location = Location.find_or_create_by(city: params[:city], latitude: params[:latitude], longitude: params[:longitude])
        user_location = Userlocation.create(user_id: @user.id, location_id: location.id)
        render json: {locations: Location.all, user: UserSerializer.new(@user)}
    end 
end
