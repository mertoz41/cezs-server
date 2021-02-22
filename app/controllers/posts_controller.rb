class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        instrument_id = params[:instrument_id].to_i
        genre_id = params[:genre_id].to_i
        artist_name = params[:artist_name]
        song_name = params[:song_name]

    end 
end
