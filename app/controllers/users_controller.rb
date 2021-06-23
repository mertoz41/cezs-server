class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        user = User.create(username: params[:username], password: params[:password])
        render json: {message: "Success!"}
    end

    def show
        @user = User.find(params[:id])
        # @posts = @user.posts
        # @shares = @user.shares
        render json: {user: UserSerializer.new(@user)}
    end 

    def avatar
        @user = User.find(params[:user_id])
        @user.avatar.attach(params[:avatar])
        # @posts = @user.posts
        render json: {user: UserSerializer.new(@user)}
    end

    def searching
        @users = User.where("username like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: UserSerializer)}
        # serializer isnt very smart for this situation

    end

end
