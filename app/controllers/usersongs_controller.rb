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
                new_album = Album.create(name: params[:album_name], spotify_id: params[:albumSpotifyId], artist_id: new_artist.id)
                
                @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: new_artist.id, album_id: new_album.id)
                new_user_song = Usersong.create(user_id: user.id, song_id: @new_song.id)
                render json: {song: SongSerializer.new(@new_song)}
            else
                album = Album.find_by(spotify_id: params[:albumSpotifyId])
                if album
                    @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: artist.id, album_id: album.id)
                    new_user_song = Usersong.create(user_id: user.id, song_id: @new_song.id)
                    render json: {song: SongSerializer.new(@new_song)}
                else
                    new_album = Album.create(name: params[:album_name], spotify_id: params[:albumSpotifyId], artist_id: artist.id)
                    @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: artist.id, album_id: new_album.id)
                    new_user_song = Usersong.create(user_id: user.id, song_id: @new_song.id)
                    render json: {song: SongSerializer.new(@new_song)}



                end
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
    def update
        user = User.find(params[:user_id])
        old_favorite = Usersong.find_by(song_id: params[:oldSongId], user_id: user.id)
        old_favorite.destroy
        # what is to be updated
        @song = Song.find_by(spotify_id: params[:songSpotifyId])
        if @song
            # song exists
            new_favorite = Usersong.create(song_id: @song.id, user_id: user.id)
            render json: {song: SongSerializer.new(@song)}
        else
            # song doesnt exist
            artist = Artist.find_by(spotify_id: params[:artistSpotifyId])
            if !artist
                # artist doesnt exist
                new_artist = Artist.create(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
                new_album = Album.create(name: params[:album_name], spotify_id: params[:albumSpotifyId], artist_id: new_artist.id)
                @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: new_artist.id, album_id: new_album.id)
                new_favorite = Usersong.create(song_id: @new_song.id, user_id: user.id)
                render json: {song: SongSerializer.new(@new_song)}
            else
                # artist exists
                album = Album.find_by(spotify_id: params[:albumSpotifyId])
                if album
                    # album exists
                    @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: artist.id, album_id: album.id)
                    new_favorite = Usersong.create(song_id: @new_song.id, user_id: user.id)
                    render json: {song: SongSerializer.new(@new_song)}
                else
                    # album doesnt exit
                    new_album = Album.create(name: params[:album_name], spotify_id: params[:albumSpotifyId], artist_id: artist.id)
                    @new_song = Song.create(name: params[:name], spotify_id: params[:songSpotifyId], artist_id: artist.id, album_id: new_album.id)
                    new_favorite = Usersong.create(song_id: @new_song.id, user_id: user.id)
                    render json: {song: SongSerializer.new(@new_song)}
                end
            end
        end
    end

    def delete
        user = User.find(params[:user_id])
        song = Song.find(params[:song_id])
        usersong = Usersong.find_by(user_id: user.id, song_id: song.id)
        usersong.destroy
        if song.posts.size == 0 && song.bandposts.size == 0 && song.usersongs.size == 0
            song.destroy
        end
        render json: {message: 'favorite song successfully deleted.'}
    end
end
