class UserartistsController < ApplicationController
    def create
        @artist = Artist.find_or_create_by(spotify_id: params[:spotify_id], name: params[:artist_name])
        user_artist = Userartist.create(user_id: logged_in_user.id, artist_id: @artist.id)
        render json: {artist: ArtistSerializer.new(@artist)}
    end

    def delete
        userartist = Userartist.find_by(user_id: logged_in_user.id, artist_id: params[:artist_id])
        userartist.destroy
        render json: {message: 'users favorite artist deleted.'}
    end

    def update
        old_favorite = Userartist.find_by(artist_id: params[:id], user_id: logged_in_user.id)
        old_favorite.destroy
        @artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:spotify_id])
        new_favorite = Userartist.create(artist_id: @artist.id, user_id: logged_in_user.id)
        render json: {artist: ArtistSerializer.new(@artist)}
    end
end
