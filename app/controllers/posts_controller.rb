class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        artist_name = params[:artist_name]
        artist_spotify_id = params[:artist_spotify_id]
        song_spotify_id = params[:song_spotify_id]
        song_name = params[:song_name]
        album_name = params[:album_name]
        album_spotify_id = params[:album_spotify_id]
        features = JSON.parse params[:features]
        instruments = JSON.parse params[:instruments]
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_spotify_id)
        album = Album.find_or_create_by(name: album_name, spotify_id: album_spotify_id, artist_id: artist.id)
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id, spotify_id: song_spotify_id, album_id: album.id)
        genre = Genre.find_or_create_by(name: params[:genre])
        @post = Post.create(user_id: user_id, artist_id: artist.id, song_id: song.id, genre_id: genre.id, description: params[:description])
        if features.length > 0
            features.each do |id|
                Postfeature.create(user_id: id, post_id: @post.id)
            end
        end
        instruments.each do |instrument|
            inst = Instrument.find_or_create_by(name: instrument)
            Postinstrument.create(instrument_id: inst.id, post_id: @post.id)
        end
        @post.clip.attach(params[:clip])
        @post.thumbnail.attach(params[:thumbnail])
        render json: @post, serializer: PostSerializer
    end

    def createuserdescpost
        user_id = params[:user_id].to_i
        description = params[:description]
        features = JSON.parse params[:features]
        instruments = JSON.parse params[:instruments]
        genre = Genre.find_or_create_by(name: params[:genre])

        @new_post = Post.create(user_id: user_id, description: description, genre_id: genre.id)
        if features.length > 0
            features.each do |id|
                Postfeature.create(user_id: id, post_id: @new_post.id)
            end
        end
        
        instruments.each do |instrument|
            inst = Instrument.find_or_create_by(name: instrument)
            Postinstrument.create(instrument_id: inst.id, post_id: @new_post.id)
        end

        @new_post.clip.attach(params[:clip])
        @new_post.thumbnail.attach(params[:thumbnail])
        render json: @new_post, serializer: PostSerializer
    end

    def createbandpost
        band_id = params[:band_id].to_i
        artist_name = params[:artist_name]
        artist_spotify_id = params[:artist_spotify_id]
        song_spotify_id = params[:song_spotify_id]
        song_name = params[:song_name]
        album_name = params[:album_name]
        album_spotify_id = params[:album_spotify_id]
        instruments = JSON.parse params[:instruments]
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_spotify_id)
        album = Album.find_or_create_by(name: album_name, artist_id: artist.id, spotify_id: album_spotify_id)
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id, album_id: album.id, spotify_id: song_spotify_id)
        genre = Genre.find_or_create_by(name: params[:genre])
        @post = Post.create(band_id: band_id, artist_id: artist.id, song_id: song.id, genre_id: genre.id)
        instruments.each do |instrument| 
            inst = Instrument.find_or_create_by(name: instrument)
            Postinstrument.create(post_id: @post.id, instrument_id: inst.id)
        end
       
        @post.clip.attach(params[:clip])
        @post.thumbnail.attach(params[:thumbnail])
        render json: @post, serializer: PostSerializer
    end

    def createbanddescposts
        band_id = params[:band_id].to_i
        description = params[:description]
        genre = Genre.find_or_create_by(name: params[:genre])
        instruments = JSON.parse params[:instruments]
        @new_post = Post.create(band_id: band_id, description: description, genre_id: genre.id)
        instruments.each do |instrument|
            inst = Instrument.find_or_create_by(name: instrument)
            Postinstrument.create(post_id: @new_post.id, instrument_id: inst.id)
        end
        @new_post.clip.attach(params[:clip])
        @new_post.thumbnail.attach(params[:thumbnail])
        render json: @new_post, serializer: PostSerializer
    end

    def show
        @post = Post.find(params[:id])
        render json: @post, serializer: PostSerializer
    end
    


    def filter
        instruments = params[:selected_instruments]
        genres = params[:selected_genres]
        states = params[:selected_states]
        @posts = []

        if instruments.length > 0
            instruments.each do |inst|
                instrument = Instrument.find(inst)
                instrument.posts.each do |post|
                    if !@posts.include?(post)
                        @posts.push(post)
                    end
                end
                
            end
        end

        if genres.length > 0
            genres.each do |genr|
                genre = Genre.find(genr)
                genre.posts.each do |post|
                    if !@posts.include?(post)
                        @posts.push(post)
                    end
                end
                
            end
        end


        if states.length > 0
            states.each do |state|
                users = User.joins(:location).merge(Location.where("city like?", "%#{state}%"))
                bands = Band.joins(:location).merge(Location.where("city like?", "%#{state}%"))
                users.each do |user|

                    user.posts.each do |post|
                        if !@posts.include?(post)
                            @posts.push(post)
                        end
                    end

                    

                end

                bands.each do |band|
                    band.posts.each do |post|
                        if !@posts.include?(post)
                            @posts.push(post)
                        end
                    end
                end
            end

                

        end
        render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
    end

    def createview
        user = User.find(params[:user_id])
        post = Post.find(params[:post_id])
        Postview.create(user_id: user.id, post_id: post.id)
        render json: {message: 'view counted'}
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: {message: 'post deleted.'}
    end

end
