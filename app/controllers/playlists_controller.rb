class PlaylistsController < ApplicationController
    def newplaylist
        @playlist = Playlist.create(user_id: params[:user_id], name: params[:name])
        render json: @playlist, serializer: PlaylistSerializer
    end
end
