class ArtistsController < ApplicationController
    def searching
        artists = Artist.where("name like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {artists: artists}
        # serializer isnt very smart for this situation
    end

    def check
        artist = Artist.find_by(spotify_id: params[:spotify_id])
        if artist
            @posts = artist.posts
            render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
        else
            render json: {message: 'Artist not found'}
        end
    end
end
