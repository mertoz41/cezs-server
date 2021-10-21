class SongsController < ApplicationController
    def show
        @song = Song.find(params[:id])
        render json: {song: SongSerializer.new(@song)}
    end
    
    def searching
        @songs = Song.where(Song.arel_table[:name].lower.matches("%#{params[:searching].downcase}%"))
        # partial string matching on a database object. not a very good solution
        render json: {songs: ActiveModel::Serializer::CollectionSerializer.new(@songs, each_serializer: SongSerializer)}
        # serializer isnt very smart for this situation
    end

    def check
        @song = Song.find_by(spotify_id: params[:id])
        if @song
            render json: {song: SongSerializer.new(@song)}
        else
            render json: {message: 'song not found'}
        end
    end

    def songfollowers
        song = Song.find(params[:id])
        @users = song.followingusers
        render json: @users, each_serializer: ShortUserSerializer
    end
    def songfavorites
        song = Song.find(params[:id])
        @users = song.favoriteusers
        render json: @users, each_serializer: ShortUserSerializer
    end
    def songfollow
        user = User.find(params[:user_id])
        artist = Artist.find_by(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
        if artist
            album = Album.find_or_create_by(name: params[:album_name], spotify_id: params[:albumSpotifyId], artist_id: artist.id)
            @song = Song.find_or_create_by(name: params[:name], artist_id: artist.id, album_id: album.id, spotify_id: params[:songSpotifyId])
            followed_song = Songfollow.create(song_id: @song.id, user_id: params[:user_id])
            render json: {song: {spotify_id: @song.spotify_id, song_id: @song.id}}
        else
            new_artist = Artist.create(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
            new_album = Album.create(name: params[:album_name], spotify_id: params[:albumSpotifyId], artist_id: new_artist.id)
            @new_song = Song.create(name: params[:name], artist_id: new_artist.id, album_id: new_album.id, spotify_id: params[:songSpotifyId])
            followed_song = Songfollow.create(song_id: @new_song.id, user_id: params[:user_id])
            render json: {song: {spotify_id: @new_song.spotify_id, song_id: @new_song.id}}
        end
    end

    def songunfollow
        old_follow = Songfollow.find_by(user_id: params[:user_id], song_id: params[:song_id])
        old_follow.destroy
        render json: {message: 'song unfollowed.'}
    end
end
