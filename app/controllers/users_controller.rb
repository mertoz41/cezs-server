class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        user = User.new(username: params[:username], password: params[:password], email: params[:email])
        if user.valid?
            user.save
            render json: {message: "Success!"}
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def show
        @user = User.find(params[:id])
        render json: {user: UserSerializer.new(@user)}
    end 

    def passwordcheck
        if logged_in_user.authenticate(params[:password])
            render json: {confirmed: true}
        else
            render json: {confirmed: false}
        end
    end

    def changepassword
        user = logged_in_user
        user.update(password: params[:password]) 
        if user.valid?
            render json: {message: 'password changed'}
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def userposts
        user = User.find(params[:id])
        bandposts = []
        user.bands.each do |band|
            bandposts = bandposts + band.posts
        end
        @posts = user.posts + bandposts
        render json: @posts, each_serializer: PostSerializer
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
            if found
                render json: {error: 'this name is being used.'}
            else
                user.update(username: params[:username])
                render json: {username: user.username}
            end
        else 
            render json: {message: 'somethings changed'}
        end

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
        render json: @users, each_serializer: ShortUserSerializer
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
    
    def filtersearch
        
        instrument_users = User.joins(:instruments).merge(Instrument.where(id: params[:instruments]))
        genre_users = User.joins(:genres).merge(Genre.where(id: params[:genres]))
        @users = instrument_users + genre_users
        render json: @users.uniq, each_serializer: ShortUserSerializer
    end

end
