class SongsController < ApplicationController
    def searching
        songs = Song.where("name like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {songs: songs}
        # serializer isnt very smart for this situation
    end
end
