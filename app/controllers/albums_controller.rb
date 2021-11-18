class AlbumsController < ApplicationController
    def albumcheck
        @album = Album.find_by(spotify_id: params[:id])
        if @album
            render json: {album: AlbumSerializer.new(@album)}
        else
            render json: {message: 'album not found'}
        end
    end
    def albumfollow
        # find artist instance first
        artist = Artist.find_or_create_by(name: params[:artistName], spotify_id: params[:artistSpotifyId])
        album = Album.find_or_create_by(name: params[:name], artist_id: artist.id, spotify_id: params[:spotify_id])
        album_follow = Albumfollow.create(user_id: logged_in_user.id, album_id: album.id)
        render json: {message: "now following #{album.name}.", album_id: album.id}
    end
    def albumunfollow
        album_follow = Albumfollow.find_by(user_id: logged_in_user.id, album_id: params[:id])
        album_follow.destroy
        render json: {message: 'unfollowed.'}
    end
    def albumfollowers
        album = Album.find(params[:id])
        @users = album.followingusers
        render json: @users, each_serializer: ShortUserSerializer
    end

    def albumsongs
        album = Album.find(params[:id])
        render json: {songs: album.songs}
    end
    def albumfavorites
        album = Album.find(params[:id])
        @users = album.favoriteusers
        render json: @users, each_serializer: ShortUserSerializer
    end
end
