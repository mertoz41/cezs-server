class SongsController < ApplicationController
    def show
        song = Song.find(params[:id])
        if song
            follows = logged_in_user.songfollows.find_by(song_id: song.id) ? true : false
            user_favorites = logged_in_user.usersongs.find_by(song_id: song.id) ? true : false
            posts = filter_blocked_posts(song.posts)
            render json: {song: SongSerializer.new(song), follows: follows, user_favorites: user_favorites, posts: ActiveModel::Serializer::CollectionSerializer.new(posts, serializer: ShortPostSerializer)}
        else
            render json: {message: 'song not found'}
        end
    end
  
    def searching
        songs = Song.where("lower(name) like?", "%#{params[:searching]}%")
        render json: {songs: ActiveModel::Serializer::CollectionSerializer.new(songs, each_serializer: SongSerializer)}
    end

    def songfollow
        artist = Artist.find_or_create_by(name: params[:artist_name])
        @song = Song.find_or_create_by(name: params[:name], artist_id: artist.id)
        followed_song = Songfollow.create(song_id: @song.id, user_id: logged_in_user.id)
        render json: {song: SongSerializer.new(@song)}
    end

    def songunfollow
        old_follow = Songfollow.find_by(user_id: logged_in_user.id, song_id: params[:id])
        old_follow.destroy
        render json: {message: 'song unfollowed.'}
    end
end
