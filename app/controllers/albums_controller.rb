class AlbumsController < ApplicationController
    def albumcheck
        byebug
        album = Album.find_by(spotify_id: params[:id])
        
    end
end
