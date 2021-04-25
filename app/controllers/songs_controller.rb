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
end
