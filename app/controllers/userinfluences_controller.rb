class UserinfluencesController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        artist_id = params[:artist_id]
        artist_name = params[:artist_name]
        
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_id, avatar: params[:artist_pic])
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
