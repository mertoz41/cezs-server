class PlaylistsController < ApplicationController
    def newplaylist
        @playlist = Playlist.create(user_id: params[:user_id], name: params[:name])
        render json: @playlist, serializer: PlaylistSerializer
    end

    def addtoplaylist
        PlaylistPost.create(post_id: params[:post_id], playlist_id: params[:list_id])
        render json: {message: 'post added to'}
    end

    def show
        playlist = Playlist.find(params[:id])
        @posts = playlist.posts
        render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
    end

    def removefromplaylist
        plpost = PlaylistPost.find_by(post_id: params[:post_id], playlist_id: params[:playlist_id])
        plpost.destroy
        render json: {message: 'post removed.'}
    end
end
