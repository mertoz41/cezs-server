class PostsController < ApplicationController

    def create
        genre = Genre.find_or_create_by(name: params[:genre])
        @post = Post.create(genre_id: genre.id, description: params[:description])
        if params[:user_id]
            @post.update_column "user_id", params[:user_id].to_i
        else
            @post.update_column "band_id", params[:band_id].to_i
        end

        if params[:artist_name]
            artist_name = params[:artist_name]
            artist_spotify_id = params[:artist_spotify_id]
            song_spotify_id = params[:song_spotify_id]
            song_name = params[:song_name]
            album_name = params[:album_name]
            album_spotify_id = params[:album_spotify_id]
            artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_spotify_id)
            album = Album.find_or_create_by(name: album_name, spotify_id: album_spotify_id, artist_id: artist.id)
            song = Song.find_or_create_by(name: song_name, artist_id: artist.id, spotify_id: song_spotify_id, album_id: album.id)
            @post.update_column "artist_id", artist.id
            @post.update_column "song_id", song.id
        end
        
        instruments = JSON.parse params[:instruments]
        instruments.each do |instrument|
            inst = Instrument.find_or_create_by(name: instrument)
            Postinstrument.create(instrument_id: inst.id, post_id: @post.id)
        end
        @post.clip.attach(params[:clip])        
        ConvertVideoJob.perform_later(@post.id, logged_in_user.id)

        @post.thumbnail.attach(params[:thumbnail])
        # render json: {message: 'uploading'}

        render json: @post, serializer: PostSerializer
    end

    def show
        @post = Post.find(params[:id])
        render json: @post, serializer: PostSerializer
    end
    
    def filter_search
        instruments = params[:instruments]
        genres = params[:genres]
        all_posts = []

        if instruments.length > 0
            instruments.each do |inst|
                instrument = Instrument.find(inst)
                instrument.posts.each do |post|
                    if !all_posts.include?(post)
                        all_posts.push(post)
                    end
                end
                
            end
        end

        if genres.length > 0
            genres.each do |genr|
                genre = Genre.find(genr)
                genre.posts.each do |post|
                    if !all_posts.include?(post)
                        all_posts.push(post)
                    end
                end
                
            end
        end
        posts = []
        if logged_in_user.blocked_users.size || logged_in_user.blocked_bands.size || logged_in_user.blocking_users.size
            posts = filter_blocked_posts(all_posts)
        else 
            posts = all_posts
        end
        render json: posts, each_serializer: ShortPostSerializer
    end
    def musicposts
        @posts = Post.where(id: params[:posts])
        render json: @posts, each_serializer: PostSerializer
    end

    def createview
        Postview.create(user_id: logged_in_user.id, post_id: params[:id].to_i)
        render json: {message: 'view counted'}
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: {message: 'post deleted.'}
    end

end
