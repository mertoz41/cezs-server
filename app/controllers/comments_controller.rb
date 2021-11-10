class CommentsController < ApplicationController
    include Rails.application.routes.url_helpers

    def show
        post = Post.find(params[:id])
        @comments = post.comments
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: CommentSerializer)}

    end

    def create
        post = Post.find(params[:post_id])
        user = User.find(params[:user_id])
        @comment = Comment.create(comment: params[:comment], user_id: user.id, post_id: post.id)
        if post.user
            @new_notification = CommentNotification.create(user_id: post.user.id, post_id: post.id, action_user_id: user.id, seen: false)
            if post.user.notification_token
                SendNotificationJob.perform_later(
                    post.user.notification_token.token,
                    "#{user.username} commented on your post!",
                    CommentNotificationSerializer.new(@new_notification).as_json
                )

            end
        else
            # notifications for band members if post is a band post
            post.band.members.each do |member|
                @new_notification = CommentNotification.create(user_id: member.id, post_id: post.id, action_user_id: user.id, seen: false)
                if member.notification_token
                    SendNotificationJob.perform_later(
                    member.notification_token.token,
                    "#{user.username} commented on your post!",
                    CommentNotificationSerializer.new(@new_notification).as_json
                )
                end
            end
        end

        render json: {comment: CommentSerializer.new(@comment)}
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: {message: 'comment deleted.'}
    end
    
end
