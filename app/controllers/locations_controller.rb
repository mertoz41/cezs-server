class LocationsController < ApplicationController
    def index
        @locations = Location.all
        render json: {locations: ActiveModel::Serializer::CollectionSerializer.new(@locations, each_serializer: LocationSerializer)}
        # how can all locations except current users be shown so that loggedin users location isnt filtered out post process.
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
