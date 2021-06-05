class UserartistsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        @artist = Artist.find_by(spotify_id: params[:artistSpotifyId])

        if @artist
            user_artist = Userartist.create(user_id: user.id, artist_id: @artist.id)
            render json: {artist: ArtistSerializer.new(@artist)}
            # create userartist instance
        else
            @new_artist = Artist.create(name: params[:name], spotify_id: params[:artistSpotifyId])
            user_artist = Userartist.create(user_id: user.id, artist_id: @new_artist.id)
            render json: {artist: ArtistSerializer.new(@new_artist)}

            # create artist first
            # create user artist instance
        end
    end
end
