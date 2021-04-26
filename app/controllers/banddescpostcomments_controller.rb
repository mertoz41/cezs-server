class BanddescpostcommentsController < ApplicationController
    def show
        banddescpost = Banddescpost.find(params[:id])
        @comments = banddescpost.banddescpostcomments
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: BanddescpostcommentSerializer)}
    end 

    def create
        user = User.find(params[:user_id])
        banddescpost = Banddescpost.find(params[:banddescpost_id])
        @new_comment = Banddescpostcomment.create(comment: params[:comment], user_id: user.id, banddescpost_id: banddescpost.id)
        render json: {comment: BanddescpostcommentSerializer.new(@new_comment)}

    end
end
