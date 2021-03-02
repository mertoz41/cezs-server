class LocationsController < ApplicationController
    def index
        locations = Location.all
        render json: {locations: locations}
    end 
    def create
        @user = User.find(params[:user_id])
        latitude = params[:latitude]
        longitude = params[:longitude]
        district = params[:district]
        Location.create(latitude: latitude, longitude: longitude, user_id: @user.id, district: district)
        render json: @user, serializer: UserSerializer
    end 
end
