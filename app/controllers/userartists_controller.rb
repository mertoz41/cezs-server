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
    def update
        user = User.find(params[:user_id])
        old_favorite = Userartist.find_by(artist_id: params[:oldArtistId], user_id: user.id)
        old_favorite.destroy
        @artist = Artist.find_by(spotify_id: params[:artistSpotifyId])
        if @artist
            new_favorite = Userartist.create(artist_id: @artist.id, user_id: user.id)
            render json: {artist: ArtistSerializer.new(@artist)}
        else
            @new_artist = Artist.create(name: params[:name], spotify_id: params[:artistSpotifyId])
            new_favorite = Userartist.create(artist_id: @new_artist.id, user_id: user.id)
            render json: {artist: ArtistSerializer.new(@new_artist)}
        end
        
    end
end
