class PlaylistsController < ApplicationController
    def newplaylist
        @playlist = Playlist.create(user_id: params[:user_id], name: params[:name])
        render json: @playlist, serializer: PlaylistSerializer
    end

    def addtoplaylist
        # user_id needed for action_user_id
        playlist = Playlist.find(params[:list_id])

        plpost = PlaylistPost.create(post_id: params[:post_id], playlist_id: playlist.id)
        # post owner will be notified DUHHHH

        client = Exponent::Push::Client.new
        messages = []

        if plpost.post.user
            # if post is userpost
            @new_notification = PlaylistNotification.create(post_id: plpost.post.id, playlist_id: playlist.id, user_id: plpost.post.user.id, action_user_id: playlist.user.id, seen: false)
            if plpost.post.user.notification_token
                obj = {
                    to: plpost.post.user.notification_token.token,
                    body: "#{playlist.user.username} added your post to #{playlist.name}.",
                    data: PlaylistNotificationSerializer.new(@new_notification)
                }
                messages.push(obj)
            end
        else
            # if post is a bandpost
            plpost.post.band.members.each do |member|
                @new_notification = PlaylistNotification.create(post_id: plpost.post.id, playlist_id: playlist.id, user_id: member.id, action_user_id: playlist.user.id, seen: false)
                if member.notification_token
                    obj = {to: member.notification_token.token,
                                body: "#{playlist.user.username} added #{plpost.band.name}#{plpost.band.name.last == 's' ? "'" : "'s"} post to #{playlist.name}.",
                                data: PlaylistNotificationSerializer.new(@new_notification)
                    }
                    messages.push(obj)
                end
            end


        end

        handler = client.send_messages(messages)
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
    def deleteplaylist
        playlist = Playlist.find_by(user_id: params[:user_id], id: params[:playlist_id])
        playlist.destroy
        render json: {message: 'playlist deleted.'}
    end
end