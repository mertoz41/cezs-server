class CommentsController < ApplicationController
    def show
        post = Post.find(params[:id])
        @comments = post.comments
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: CommentSerializer)}

    end

    def create
        post = Post.find(params[:post_id])
        user = User.find(params[:user_id])
        @comment = Comment.create(comment: params[:comment], user_id: user.id, post_id: post.id)
        render json: {comment: CommentSerializer.new(@comment)}
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: {message: 'comment deleted.'}
    end
end
