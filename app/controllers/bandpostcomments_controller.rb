class BandpostcommentsController < ApplicationController
    def show
        bandpost = Bandpost.find(params[:id])
        @comments = bandpost.bandpostcomments
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: BandpostcommentSerializer)}
    end 
    def create
        user = User.find(params[:user_id])
        bandpost = Bandpost.find(params[:bandpost_id])
        @comment = Bandpostcomment.create(user_id: user.id, comment: params[:comment], bandpost_id: bandpost.id)
        render json: {comment: BandpostcommentSerializer.new(@comment)}
    end
end
