class RequestsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        byebug
        artist = Artist.find_or_create_by(name: params[:artistName])
        song = Song.find_or_create_by(name: params[:songName], artist_id: artist.id)
        @new_request = Request.create(user_id: user.id, artist_id: artist.id, song_id: song.id, fulfilled: false)

        render json: @new_request, serializer: RequestSerializer
        end
end
