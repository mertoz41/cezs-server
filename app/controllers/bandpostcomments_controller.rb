class BandpostcommentsController < ApplicationController
    def show
        bandpost = Bandpost.find(params[:id])
        @comments = bandpost.bandpostcomments
        render json: {comments: ActiveModel::Serializer::CollectionSerializer.new(@comments, each_serializer: BandpostcommentSerializer)}
    end 
end
