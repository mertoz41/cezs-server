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
        @new_notification = CommentNotification.create(user_id: post.user.id, post_id: post.id, action_user_id: user.id, seen: false)
        if post.user.notification_token
            client = Exponent::Push::Client.new
            # byebug
            messages = [{
            to: post.user.notification_token.token,
            body: "#{user.username} commented on your post!",
            data: CommentNotificationSerializer.new(@new_notification)
            }]
            handler = client.send_messages(messages)
            # SendNotificationJob.perform_later post, user, @new_notification
            
        end
        render json: {comment: CommentSerializer.new(@comment)}
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: {message: 'comment deleted.'}
    end
end
