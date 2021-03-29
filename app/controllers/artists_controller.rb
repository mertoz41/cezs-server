class ArtistsController < ApplicationController
    def searching
        artists = Artist.where("name like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {artists: artists}
        # serializer isnt very smart for this situation
    end
    def show
        @artist = Artist.find(params[:id])
        @posts = @artist.posts
        render json: {artist: ArtistSerializer.new(@artist), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
    end 

    def influences
        @influences = Artist.find(params[:id]).users
        render json: {influences: ActiveModel::Serializer::CollectionSerializer.new(@influences, each_serializer: UserSerializer)}
    end 

    def check
        @artist = Artist.find_by(spotify_id: params[:spotify_id])
        if @artist
            @posts = @artist.posts
            render json: {artist: ArtistSerializer.new(@artist), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
        else
            render json: {message: 'Artist not found'}
        end
    end
end
