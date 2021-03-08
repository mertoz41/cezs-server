class UserinstrumentsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        instrument = Instrument.find(params[:instrument_id])
        user_instrument = Userinstrument.create(user_id: @user.id, instrument_id: instrument.id)
        render json: {user: UserSerializer.new(@user)}
    end 
end
