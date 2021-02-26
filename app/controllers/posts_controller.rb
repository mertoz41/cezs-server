class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        instrument_id = params[:instrument_id].to_i
        genre_id = params[:genre_id].to_i
        artist_name = params[:song_artist]
        song_name = params[:song_name]
        artist = Artist.find_or_create_by(name: artist_name)
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id)

        @post = Post.create(user_id: user_id, instrument_id: instrument_id, genre_id: genre_id, artist_id: artist.id, song_id: song.id)
        @post.clip.attach(params[:clip])
        render json: @post, serializer: PostSerializer
    end 

    def filter
        list = params[:selectedItems]
        @filtered_timeline = []
        
        list.each do |item|
            if item[:type] == 'instrument'
                posts = Post.where(instrument_id: item[:value])
                @filtered_timeline = @filtered_timeline + posts
            else 
                posts = Post.where(genre_id: item[:value])
                @filtered_timeline = @filtered_timeline + posts
            end 
        end 
        
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@filtered_timeline, each_serializer: PostSerializer)}

    end
end
