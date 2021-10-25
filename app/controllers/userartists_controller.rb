class UserartistsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        artist = Artist.find_by(spotify_id: params[:spotify_id])
        user_artist = Userartist.create(user_id: user.id, artist_id: artist.id)
        render json: {artist_id: artist.id}
    end

    def delete
        userartist = Userartist.find_by(user_id: params[:user_id], artist_id: params[:artist_id])
        userartist.destroy
        render json: {message: 'users favorite artist deleted.'}
    end

    def update
        user = User.find(params[:user_id])
        old_favorite = Userartist.find_by(artist_id: params[:oldArtistId], user_id: user.id)
        old_favorite.destroy
        artist = Artist.find_or_create_by(name: params[:name], spotify_id: params[:spotify_id])
        new_favorite = Userartist.create(artist_id: artist.id, user_id: user.id)
        render json: {artist_id: artist.id}
    end
end
