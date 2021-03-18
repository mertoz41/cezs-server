class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        instrument_id = params[:instrument_id].to_i
        genre_id = params[:genre_id].to_i
        artist_name = params[:artist_name]
        artist_id = params[:artist_id]
        song_name = params[:song_name]
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_id, avatar: params[:artist_pic])
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id)

        @post = Post.create(user_id: user_id, instrument_id: instrument_id, genre_id: genre_id, artist_id: artist.id, song_id: song.id)
        @post.clip.attach(params[:clip])
        render json: @post, serializer: PostSerializer
    end 

    def filter
        # list = params[:selectedItems]
        instruments = params[:instruments]
        genres = params[:genres]
        by_instrument = Post.where(instrument_id: instruments)
        by_genre = Post.where(genre_id: genres)
        @filtered_timeline = by_instrument + by_genre 
    
        
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@filtered_timeline, each_serializer: PostSerializer)}

    end
    def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: {message: 'post deleted.'}
    end
end
