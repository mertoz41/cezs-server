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
            song_name = params[:song_name]
            artist = Artist.find_or_create_by(name: artist_name)
            song = Song.find_or_create_by(name: song_name, artist_id: artist.id)
            @post.update_column "artist_id", artist.id
            @post.update_column "song_id", song.id
        end
        
        instruments = JSON.parse params[:instruments]
        instruments.each do |instrument|
            inst = Instrument.find_or_create_by(name: instrument)
            Postinstrument.create(instrument_id: inst.id, post_id: @post.id)
        end
        @post.clip.attach(params[:clip])        
        # ConvertVideoJob.perform_later(@post.id, logged_in_user.id)

        @post.thumbnail.attach(params[:thumbnail])

        render json: @post, serializer: PostSerializer, scope: logged_in_user
    end

    def show
        @post = Post.find(params[:id])
        render json: @post, serializer: PostSerializer, scope: logged_in_user
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
        filtered = posts.select {|post| post.reports.size < 1}
        render json: filtered, each_serializer: ShortPostSerializer
    end
    def musicposts
        @posts = Post.where(id: params[:posts])
        if !@posts.size
            render json: {message: "no more videos left to show"}
        else
            render json: @posts, each_serializer: PostSerializer, scope: logged_in_user
        end
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
