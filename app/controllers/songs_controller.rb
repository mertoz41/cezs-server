class SongsController < ApplicationController
    def show
        @song = Song.find(params[:id])
        @posts = @song.posts
        render json: {song: SongSerializer.new(@song), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
    end
    
    def searching
        @songs = Song.where("name like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {songs: ActiveModel::Serializer::CollectionSerializer.new(@songs, each_serializer: SongSerializer)}
        # serializer isnt very smart for this situation
    end
end
