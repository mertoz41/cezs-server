class UserinfluencesController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        spotify_id = params[:spotify_id]
        artist_name = params[:artist_name]
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: spotify_id)
        user_influence = Userinfluence.create(user_id: @user.id, artist_id: artist.id)
        render json: {user: UserSerializer.new(@user)}
    end

    def delete
        @user = User.find(params[:user_id])
        influence = Userinfluence.find_by(user_id: @user.id, artist_id: params[:artist_id])
        influence.destroy
        render json: {user: UserSerializer.new(@user)}
    end 
end
