class ArtistsController < ApplicationController
    def searching
        artists = Artist.where("name like?", "%#{params[:searching]}%")
        render json: {artists: ActiveModel::Serializer::CollectionSerializer.new(artists, serializer: ArtistSerializer)}
    end

    def show
        artist = Artist.find(params[:id])
        follows = logged_in_user.artistfollows.find_by(artist_id: artist.id) ? true : false
        user_favorites = logged_in_user.userartists.find_by(artist_id: artist.id) ? true : false
        posts = []
        if logged_in_user.blocked_users.size
            posts = filter_blocked_posts(artist.posts)
        else 
            posts = artist.posts
        end
        render json: {artist: ArtistSerializer.new(artist), user_favorites: user_favorites, follows: follows, posts: ActiveModel::Serializer::CollectionSerializer.new(posts, serializer: ShortPostSerializer), songs: ActiveModel::Serializer::CollectionSerializer.new(artist.songs, serializer: ShortSongSerializer) }
    end 

    def influences
        @influences = Artist.find(params[:id]).influencedusers
        render json: @influences, each_serializer: ShortUserSerializer
    end 

    def artistfollowers
        artist = Artist.find(params[:id])
        @users = artist.followingusers
        render json: @users, each_serializer: ShortUserSerializer
    end

    def artistfavorites
        artist = Artist.find(params[:id])
        @users = artist.favoriteusers
        render json: @users, each_serializer: ShortUserSerializer
    end

    def artistfollow
        @artist = Artist.find_or_create_by(name: params[:artist_name])
        new_follow = Artistfollow.create(user_id: logged_in_user.id, artist_id: @artist.id) 
        render json: {artist: ArtistSerializer.new(@artist)}
    end

    def artistunfollow
        artis_follow = Artistfollow.find_by(user_id: logged_in_user.id, artist_id: params[:id])
        artis_follow.destroy
        render json: {message: 'succezs'}
    end
end
