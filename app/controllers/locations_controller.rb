class LocationsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        latitude = params[:latitude]
        longitude = params[:longitude]
        Location.create(latitude: latitude, longitude: longitude, user_id: @user.id)
        render json: @user, serializer: UserSerializer
    end 
end
