class UsersController < ApplicationController

    def create
        user = User.create(username: params[:username], password: params[:password])
        render json: {message: "Success!"}
    end

    def avatar
        @user = User.find(params[:user_id])
        @user.avatar.attach(params[:avatar])
        render json: @user, serializer: UserSerializer
    end

    def searching
        @users = User.where("username like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: UserSerializer)}
        # serializer isnt very smart for this situation

    end

end
