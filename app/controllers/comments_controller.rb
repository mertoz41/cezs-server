class CommentsController < ApplicationController
    include Rails.application.routes.url_helpers

    def show
        post = Post.find(params[:id])
        @comments = post.comments
        @users = post.applauding_users
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: CommentSerializer), applauders: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: ShortUserSerializer)}

    end

    def create
        post = Post.find(params[:post_id])
        @comment = Comment.create(comment: params[:comment], user_id: logged_in_user.id, post_id: post.id)
        if post.user
            if post.user.id != logged_in_user.id
            @new_notification = Notification.create(action_user_id: logged_in_user.id, user_id: post.user.id, comment_id: @comment.id, seen: false)
            ActionCable.server.broadcast "notifications_channel_#{post.user.id}", NotificationSerializer.new(@new_notification)
            end
            # @new_notification = CommentNotification.create(user_id: post.user.id, post_id: post.id, action_user_id: user.id, seen: false)
            # if post.user.notification_token
            #     SendNotificationJob.perform_later(
            #         post.user.notification_token.token,
            #         "#{user.username} commented on your post!",
            #         CommentNotificationSerializer.new(@new_notification).as_json
            #     )

            # end
        else
            # notifications for band members if post is a band post
            post.band.members.each do |member|
                @new_notification = Notification.create(user_id: member.id, post_id: post.id, action_user_id: logged_in_user.id, seen: false, comment_id: @comment_id)
                ActionCable.server.broadcast "notifications_channel_#{ member.id}", NotificationSerializer.new(@new_notification)

                # if member.notification_token
                #     SendNotificationJob.perform_later(
                #     member.notification_token.token,
                #     "#{user.username} commented on your post!",
                #     CommentNotificationSerializer.new(@new_notification).as_json
                # )
                # end
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
