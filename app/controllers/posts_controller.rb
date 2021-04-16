class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        instrument_id = params[:instrument_id].to_i
        artist_name = params[:artist_name]
        artist_id = params[:artist_id]
        song_name = params[:song_name]
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_id, avatar: params[:artist_pic])
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id)
        
        @post = Post.create(user_id: user_id, instrument_id: instrument_id, artist_id: artist.id, song_id: song.id)
        @post.clip.attach(params[:clip])
        render json: @post, serializer: PostSerializer
    end 

    def filter
        instruments = params[:selected_instruments]
        @posts = Post.where(instrument_id: instruments)
        @bandposts = []
        instruments.each do |inst|
            instrument = Instrument.find(inst)
            instrument.bandposts.each do |post|
                @bandposts.push(post)
            end
        end
            
        # @bandposts = Bandpost.where()
        render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer), bandposts: ActiveModel::Serializer::CollectionSerializer.new(@bandposts, each_serializer: BandpostSerializer)}

    end
    def destroy
        post = Post.find(params[:id])
        song = Song.find(post.song_id)

        post.destroy
        if song.bandposts.length == 0 && song.posts.length == 0
            song.destroy
        end
        render json: {message: 'post deleted.'}
    end
end
