class ArtistsController < ApplicationController
    def searching
        artists = Artist.where("name like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {artists: artists}
        # serializer isnt very smart for this situation
    end
    def show
        @artist = Artist.find_by(spotify_id: params[:id])
        if @artist
            render json: {artist: ArtistSerializer.new(@artist)}
        else
            render json: {message: 'Artist not found'}
        end
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
    def artistposts
        artist = Artist.find(params[:id])
        @posts = artist.posts
        render json: @posts, each_serializer: PostSerializer

    end

    def artistfavorites
        artist = Artist.find(params[:id])
        @users = artist.favoriteusers
        render json: @users, each_serializer: ShortUserSerializer
    end

    def artistfollow
        @artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:spotify_id])
        new_follow = Artistfollow.create(user_id: logged_in_user.id, artist_id: @artist.id) 
        render json: {artist: ArtistSerializer.new(@artist)}
    end

    def artistunfollow
        artis_follow = Artistfollow.find_by(user_id: logged_in_user.id, artist_id: params[:id])
        artis_follow.destroy
        render json: {message: 'succezs'}
    end

end
