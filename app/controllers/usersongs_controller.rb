class UsersongsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        song = Song.find_by(spotify_id: params[:songSpotifyId])
        if song
            user_song = Usersong.create(user_id: user.id, song_id: song.id)
        else
            artist = Artist.find_by(spotify_id: params[:artistSpotifyId])
            if !artist
                new_artist = Artist.create(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
                @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: new_artist.id)
                new_user_song = Usersong.create(user_id: user.id, song_id: @new_song.id)
                render json: {song: SongSerializer.new(@new_song)}
            else
                @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: artist.id)
                new_user_song = Usersong.create(user_id: user.id, song_id: @new_song.id)
                render json: {song: SongSerializer.new(@new_song)}
            end

        end
        # find artist
        # if artist does not exist create artist
        # then create the song under that artist
        # and then create usersong instance with user and song


        # if artist does exist
        # find the song
        # if song does not exist create the song
        # and then create usersong instance
    end
end
