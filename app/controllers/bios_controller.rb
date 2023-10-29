class BiosController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        user_bio = Bio.create(description: params[:description], user_id: @user.id)
        render json: {bio: user_bio.description}
    end 

    def update
        @user = User.find(params[:user_id])
        bio = @user.bio
        bio.update(description: params[:description])
        render json: {bio: bio.description}
    end
end
