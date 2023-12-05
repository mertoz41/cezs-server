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
                CreateNotificationJob.perform_async(JSON.parse({action_user_id: logged_in_user.id, user_id: post.user.id, comment_id: @comment.id}.to_json))
            end
        else
            post.band.members.each do |member|
                CreateNotificationJob.perform_async(JSON.parse({user_id: member.id, post_id: post.id, action_user_id: logged_in_user.id, comment_id: @comment.id}.to_json))
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
