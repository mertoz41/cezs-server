class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        # byebug
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            @timeline = []
            # @posts = []
            # @shares = @user.shares
            chatrooms = []
            @user.chatrooms.each do |room|
                obj = {}
                obj = room.attributes
                @room_users = room.users
                obj['users'] = ActiveModel::Serializer::CollectionSerializer.new(@room_users, each_serializer: UserSerializer)
                chatrooms.push(obj)
            end 

            @user.posts.each do |post|
                # @posts.push(post)
                @timeline.push(post)
            end 
            @user.bands.each do |band|
                band.bandposts.each do |bandpost|
                    @timeline.push(bandpost)
                end
            end
            @user.followeds.each do |user|
                user.posts.each do |post|
                @timeline.push(post)
                end 
            end
            @user.followedbands.each do |band|
                band.bandposts.each do |bandpost|
                    @timeline.push(bandpost)
                end
            end 
            @user.followedartists.each do |artist|
                artist.posts.each do |post|
                    @timeline.push(post)
                end
                artist.bandposts.each do |post|
                    @timeline.push(post)
                end
            end 
            @user.userdescposts.each do |post|
                @timeline.push(post)
            end

            render json: {user: UserSerializer.new(@user), token: token, timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer), chatrooms: chatrooms}
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        # byebug
        token = request.headers["Authorization"].split(' ')[1]
        @user = User.find(decode(token)["user_id"])
        @timeline = []
        # @posts = []
            
        chatrooms = []
        @user.chatrooms.each do |room|
            obj = {}
            obj = room.attributes
            @room_users = room.users
            obj['users'] = ActiveModel::Serializer::CollectionSerializer.new(@room_users, each_serializer: UserSerializer)
            chatrooms.push(obj)
        end 
        # @user.followedbands.each do |band|
        #     band.bandposts.each do |bandpost|
        #         @timeline.push(bandpost)
        #     end
        # end 
        # @user.bands.each do |band|
        #     band.bandposts.each do |bandpost|
        #         @timeline.push(bandpost)
        #     end
        #     band.banddescposts.each do |banddescpost|
        #         @timeline.push(banddescpost)
        #     end
        # end
        
        @user.followedartists.each do |artist|
            artist.posts.each do |post|
                @timeline.push(post)
            end
            # artist.bandposts.each do |post|
            #     @timeline.push(post)
            # end
        end 
        
        # @shares = @user.shares
            @user.posts.each do |post|
                # @posts.push(post)
                @timeline.push(post)
            end
            @user.userdescposts.each do |post|
                @timeline.push(post)
            end
            @user.followeds.each do |user|
                user.posts.each do |post|
                @timeline.push(post)
                end
                user.userdescposts.each do |post|
                    @timeline.push(post)
                end
            end 
        
        render json: {user: UserSerializer.new(@user), timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end

end
