class ArtistsController < ApplicationController
    def searching
        artists = Artist.where("lower(name) like?", "%#{params[:searching]}%")
        render json: {artists: ActiveModel::Serializer::CollectionSerializer.new(artists, serializer: ArtistSerializer)}
    end

    def show
        artist = Artist.find(params[:id])
        posts = []
        if logged_in_user.blocked_users.size
            posts = filter_blocked_posts(artist.posts)
        else 
            posts = artist.posts
        end
        render json: {artist: ArtistSerializer.new(artist, scope: {follows: artist.user_follows(logged_in_user.id) , user_favorite:  artist.user_favorites(logged_in_user.id)}), posts: ActiveModel::Serializer::CollectionSerializer.new(posts, serializer: ShortPostSerializer), songs: ActiveModel::Serializer::CollectionSerializer.new(artist.songs, serializer: ShortSongSerializer) }
    end 

    def followers
        artist = Artist.find(params[:id])
        @users = artist.followingusers
        render json: @users, each_serializer: ShortUserSerializer
    end

    def favorites
        artist = Artist.find(params[:id])
        @users = artist.favoriteusers
        render json: @users, each_serializer: ShortUserSerializer
    end

    def follow
        @artist = Artist.find_or_create_by(name: params[:artist_name])
        new_follow = Artistfollow.create(user_id: logged_in_user.id, artist_id: @artist.id) 
        render json: {artist: ArtistSerializer.new(@artist, scope: {follows: @artist.user_follows(logged_in_user.id) , user_favorite:  @artist.user_favorites(logged_in_user.id)})}
    end

    def unfollow
        artis_follow = Artistfollow.find_by(user_id: logged_in_user.id, artist_id: params[:id])
        artis_follow.destroy
        render json: {message: 'succezs'}
    end
end
