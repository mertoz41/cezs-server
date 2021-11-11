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

    def songposts
        song = Song.find(params[:id])
        @posts = song.posts
        render json: @posts, each_serializer: PostSerializer
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
        artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
        album = Album.find_or_create_by(name: params[:album_name], artist_id: artist.id, spotify_id: params[:albumSpotifyId])
        song = Song.find_or_create_by(name: params[:name], artist_id: artist.id, album_id: album.id, spotify_id: params[:spotify_id])
        followed_song = Songfollow.create(song_id: song.id, user_id: logged_in_user.id)
        render json: {song_id: song.id}
    end

    def songunfollow
        old_follow = Songfollow.find_by(user_id: logged_in_user.id, song_id: params[:id])
        old_follow.destroy
        render json: {message: 'song unfollowed.'}
    end
end
