class UserdescpostcommentsController < ApplicationController
    def show
        userdescpost = Userdescpost.find(params[:id])
        @comments = userdescpost.userdescpostcomments
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: UserdescpostcommentSerializer)}
    end 
    def create
        user = User.find(params[:user_id])
        userdescpost = Userdescpost.find(params[:userdescpost_id])
        @comment = Userdescpostcomment.create(user_id: user.id, userdescpost_id: userdescpost.id, comment: params[:comment])
        render json: {comment: UserdescpostcommentSerializer.new(@comment)}
    end
end
