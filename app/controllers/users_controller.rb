class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    include Rails.application.routes.url_helpers

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
        user = User.find(params[:id])
        follows = logged_in_user.follows.find_by(followed_id: user.id) ? true : false
        render json: {user: UserSerializer.new(user), follows: follows }
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
        @user = User.find(params[:id])

        if params[:username]
            found = User.find_by(username: params[:username])
            if found
                render json: {error: 'this name is taken.'}
            else
                @user.update_column 'username', params[:username]
            end
        end


        if params[:name]
            @user.update_column 'name', params[:name]
        end
        if params[:email]
            @user.update_column 'email', params[:email]
        end
        if params[:bio]
            @user.update_column 'bio', params[:bio]
        end

        if params[:location]
            if @user.userlocation
                old_location = @user.userlocation
                old_location.destroy
            end
            location = Location.find_by(city: params[:location]["city"])
            if location
                new_user_location = Userlocation.create(user_id: @user.id, location_id: location.id)
            else
                new_location = Location.create(city: params[:location]["city"], latitude: params[:location]["latitude"], longitude: params[:location]["longitude"])
                new_user_location = Userlocation.create(user_id: @user.id, location_id: new_location.id)
            end
        end

        if params[:instruments]
            params[:instruments].each do |inst|
                instrument = Instrument.find_or_create_by(name: inst)
                user_instrument = Userinstrument.create(user_id: @user.id, instrument_id: instrument.id)
            end
        end

        if params[:genres]
            params[:genres].each do |genr|
                genre = Genre.find_or_create_by(name: genr)
                user_genre = Usergenre.create(user_id: @user.id, genre_id: genre.id)
            end
        end
    
        # validations are keeping me from updating only the username
        
        render json: {user: UserSerializer.new(@user)}
    end

    def avatar
        user = User.find(logged_in_user.id)
        user.avatar.attach(params[:avatar])
        # user.avatar = params[:avatar]
        # byebug
        # @posts = @user.posts
        render json: {message: 'picture changed.', avatar: url_for(user.avatar)}
    end

    def searching
        searched_users= User.where("username like?", "%#{params[:searching]}%")
        @users = searched_users.select {|user| !blocked_user_list.include?(user.id)}
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
    
    def filter_search
        
        instrument_users = User.joins(:instruments).merge(Instrument.where(id: params[:instruments]))
        genre_users = User.joins(:genres).merge(Genre.where(id: params[:genres]))
        all_users = instrument_users + genre_users
        @users = all_users.select {|user| !blocked_user_list.include?(user.id)}
        render json: @users.uniq, each_serializer: ShortUserSerializer
    end

end
