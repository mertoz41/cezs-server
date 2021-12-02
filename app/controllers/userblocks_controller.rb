class UserblocksController < ApplicationController
    def create
        new_block = UserBlock.create(blocked_id: params[:user_id], blocking_id: logged_in_user.id)
        # check if user follows blocked user, if so delete follow
        render json: {message: 'user blocked.'}
    end
    def blockedusers
        @users = logged_in_user.blocked_users
        render json: @users, each_serializer: ShortUserSerializer
    end
    def unblockuser
        userblock = UserBlock.find_by(blocked_id: params[:id], blocking_id: logged_in_user.id)
        userblock.destroy
        render json: {message: 'user unblocked'}
    end
end
