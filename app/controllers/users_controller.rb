class UsersController < ApplicationController

    def create
        user = User.create(username: params[:username], password: params[:password])
        render json: {message: "Success!"}
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        render json: {user: UserSerializer.new(@user), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
    end 

    def avatar
        @user = User.find(params[:user_id])
        @user.avatar.attach(params[:avatar])
        @posts = @user.posts
        render json: {user: UserSerializer.new(@user), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
    end

    def searching
        @users = User.where("username like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: UserSerializer)}
        # serializer isnt very smart for this situation

    end

end
