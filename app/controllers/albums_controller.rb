class AlbumsController < ApplicationController
    def albumcheck
        album = Album.find_by(spotify_id: params[:id])
        if album
            render json: {songs: ActiveModel::Serializer::CollectionSerializer.new(album.songs, each_serializer: SongSerializer)}
        else
            render json: {message: 'album not found'}
        end
    end
end
