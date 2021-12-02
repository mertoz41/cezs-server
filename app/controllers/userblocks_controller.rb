class UserblocksController < ApplicationController
    def create
        new_block = UserBlock.create(blocked_id: params[:user_id], blocking_id: logged_in_user.id)
        # check if user follows blocked user, if so delete follow
        render json: {message: 'user blocked.'}
    end
end
