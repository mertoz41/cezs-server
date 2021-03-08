class UserinstrumentsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        instrument = Instrument.find(params[:instrument_id])
        user_instrument = Userinstrument.create(user_id: @user.id, instrument_id: instrument.id)
        render json: {user: UserSerializer.new(@user)}
    end 
    def delete
        @user = User.find(params[:user_id])
        user_instrument = Userinstrument.find_by(user_id: @user.id, instrument_id: params[:instrument_id])
        user_instrument.destroy
        render json: {user: UserSerializer.new(@user)}
    end
end
