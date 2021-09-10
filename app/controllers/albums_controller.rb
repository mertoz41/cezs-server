class AlbumsController < ApplicationController
    def albumcheck
        @album = Album.find_by(spotify_id: params[:id])
        if @album
            render json: {album: AlbumSerializer.new(@album)}
        else
            render json: {message: 'album not found'}
        end
    end

    def albumsongs
        album = Album.find(params[:id])
        render json: {songs: album.songs}
    end
end
