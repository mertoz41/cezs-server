class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        instrument_id = params[:instrument_id].to_i
        artist_name = params[:artist_name]
        spotify_id = params[:spotify_id]
        song_name = params[:song_name]
        # find artist by artist name and spotify id
        # if artist found use it for post creation
        artist = Artist.find_by(name: artist_name, spotify_id: spotify_id)
        if artist
            song = Song.find_or_create_by(name: song_name, artist_id: artist.id)
            @post = Post.create(user_id: user_id, instrument_id: instrument_id, artist_id: artist.id, song_id: song.id, thumbnail: params[:thumbnail])
            @post.clip.attach(params[:clip])
            render json: @post, serializer: PostSerializer
        else
        # if not create an artist instance
        # then create post instance
            new_artist = Artist.create(name: artist_name, spotify_id: spotify_id, avatar: params[:artist_pic])
            song = Song.create(name: song_name, artist_id: new_artist.id)
            @post = Post.create(user_id: user_id, instrument_id: instrument_id, artist_id: new_artist.id, song_id: song.id, thumbnail: params[:thumbnail])
            @post.clip.attach(params[:clip])
            render json: @post, serializer: PostSerializer
        end

    end 

    def filter
        instruments = params[:selected_instruments]
        # byebug
        if instruments.length > 0 
            @posts = Post.where(instrument_id: instruments)
            @userdescposts = Userdescpost.where(instrument_id: instruments)
            @bandposts = []
            @banddescposts = []
            instruments.each do |inst|
                instrument = Instrument.find(inst)
                instrument.bandposts.each do |post|
                    @bandposts.push(post)
                end
                instrument.banddescposts.each do |post|
                    @banddescposts.push(post)
                end
            end
            render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer), bandposts: ActiveModel::Serializer::CollectionSerializer.new(@bandposts, each_serializer: BandpostSerializer), userdescposts: ActiveModel::Serializer::CollectionSerializer.new(@userdescposts, each_serializer: UserdescpostSerializer), banddescposts: ActiveModel::Serializer::CollectionSerializer.new(@banddescposts, each_serializer: BanddescpostSerializer)}

            
        end
        
        if params[:song_name].length > 0 
            songs = Song.where(Song.arel_table[:name].lower.matches("%#{params[:song_name].downcase}%"))
            # byebug
            
            @bandposts = []
            @posts = []
            songs.each do |song|
                song.posts.each do |post|
                    @posts.push(post)
                end
                song.bandposts.each do |post|
                    @bandposts.push(post)
                end
               
                # @bandposts.push(songbandpost)
            end
            render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer), bandposts: ActiveModel::Serializer::CollectionSerializer.new(@bandposts, each_serializer: BandpostSerializer)}
                
        end
        if params[:artist_name].length > 0
            artists = Artist.where(Artist.arel_table[:name].lower.matches("%#{params[:artist_name].downcase}%"))
            @bandposts = []
            @posts = []
            artists.each do |artis|
                artis.posts.each do |post|
                    @posts.push(post)
                end
                artis.bandposts.each do |post|
                    @bandposts.push(post)
                end
            end
            render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer), bandposts: ActiveModel::Serializer::CollectionSerializer.new(@bandposts, each_serializer: BandpostSerializer)}
        end

        
        
        
        
        
        
        
        # if params[:song_name].length
        #     posts
        
        # @bandposts = Bandpost.where()
        
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
