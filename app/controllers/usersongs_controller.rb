class UsersongsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:artist_spotify_id])
        album = Album.find_or_create_by(name: params[:album_name], spotify_id: params[:album_spotify_id], artist_id: artist.id)
        @song = Song.find_or_create_by(spotify_id: params[:spotify_id], album_id: album.id, artist_id: artist.id, name: params[:name])
        user_song = Usersong.create(user_id: user.id, song_id: @song.id)
        render json: {song: SongSerializer.new(@song)}
    end

    def update
        user = User.find(params[:user_id])
        old_favorite = Usersong.find_by(song_id: params[:oldSongId], user_id: user.id)
        old_favorite.destroy
        artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
        album = Album.find_or_create_by(name: params[:album_name], artist_id: artist.id, spotify_id: params[:albumSpotifyId])
        @song = Song.find_or_create_by(name: params[:name], artist_id: artist.id, spotify_id: params[:spotify_id], album_id: album.id)
        new_favorite = Usersong.create(song_id: @song.id, user_id: user.id)
        render json: {song: SongSerializer.new(@song)}
    end

    def delete
        user = User.find(params[:user_id])
        song = Song.find(params[:song_id])
        usersong = Usersong.find_by(user_id: user.id, song_id: song.id)
        usersong.destroy
        render json: {message: 'favorite song successfully deleted.'}
    end
end
