class SongsController < ApplicationController
    def show
        @song = Song.find(params[:id])
        @user_posts = @song.posts
        @band_posts = @song.bandposts
        
        render json: {song: SongSerializer.new(@song), 
        posts: ActiveModel::Serializer::CollectionSerializer.new(@user_posts, each_serializer: PostSerializer),
        bandposts: ActiveModel::Serializer::CollectionSerializer.new(@band_posts, each_serializer: PostSerializer)}
    end
    
    def searching
        @songs = Song.where(Song.arel_table[:name].lower.matches("%#{params[:searching].downcase}%"))
        # partial string matching on a database object. not a very good solution
        render json: {songs: ActiveModel::Serializer::CollectionSerializer.new(@songs, each_serializer: SongSerializer)}
        # serializer isnt very smart for this situation
    end
end
