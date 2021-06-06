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
    def delete
        user = User.find(params[:user_id])
        artist = Artist.find(params[:artist_id])
        userartist = Userartist.find_by(user_id: user.id, artist_id: artist.id)
        userartist.destroy
        if artist.posts.size == 0 && artist.bandposts.size == 0 && artist.userinfluences.size == 0 && artist.artistfollows.size == 0 && artist.userartists.size == 0
            artist.destroy
        end
        render json: {message: 'users favorite artist deleted.'}
    end
end
