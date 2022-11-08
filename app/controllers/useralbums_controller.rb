class UseralbumsController < ApplicationController
    def create
        artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:artist_spotify_id])
        @album = Album.find_or_create_by(name: params[:name], artist_id: artist.id, spotify_id: params[:spotify_id])
        user_album = Useralbum.create(user_id: logged_in_user.id, album_id: @album.id)
        render json: {album: AlbumSerializer.new(@album)}
    end

    def delete
        album = Album.find(params[:album_id])
        user_album = Useralbum.find_by(user_id: logged_in_user.id, album_id: album.id)
        user_album.destroy
        if album.songs.size == 0 && album.favoriteusers.size == 0
            album.destroy
        end
        render json: {message: 'users favorite album deleted.'}
    end

    def update
        old_favorite = Useralbum.find_by(user_id: logged_in_user.id, album_id: params[:id])
        old_favorite.destroy
        artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:artist_spotify_id])
        @album = Album.find_or_create_by(name: params[:name], artist_id: artist.id, spotify_id: params[:spotify_id])
        new_favorite = Useralbum.create(user_id: logged_in_user.id, album_id: @album.id)
        render json: {album: AlbumSerializer.new(@album)}
    end
end
