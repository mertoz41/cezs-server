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

    def update
        user = User.find(params[:id])

        if params[:name]
            user.update(name: params[:name])
        end
        if params[:last_name]
            user.update(last_name: params[:last_name])
        end
        if params[:email]
            user.update(email: params[:email])
        end

        if params[:username]
            found = User.find_by(username: params[:username])
            # byebug
            if found
                render json: {error: 'this name is being used.'}
            else
                user.update(username: params[:username])
                render json: {username: user.username}
            end
        else 
            render json: {message: 'somethings changed'}
        end

        # render json: {username: user.username}
    end

    def avatar
        @user = User.find(params[:user_id])
        byebug
        @user.avatar.attach(params[:avatar])
        # @posts = @user.posts
        render json: {message: 'avatar changed.'}
    end

    def searching
        @users = User.where("username like?", "%#{params[:searching]}%")
        # partial string matching on a database object. not a very good solution
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: SearchUserSerializer)}
        # serializer isnt very smart for this situation

    end
    def usertoken
        user = User.find(params[:user_id])
        if !user.notification_token
            new_expo_token = NotificationToken.create(user_id: user.id, token: params[:expo_token])
        else
            token = user.notification_token
            token.update(token: params[:expo_token])
        end
        render json: {message: 'token added.'}
    end

end
