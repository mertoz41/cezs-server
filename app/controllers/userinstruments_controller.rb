class UserinstrumentsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        instrument = Instrument.find_or_create_by(name: params[:instrument])
        user_instrument = Userinstrument.create(user_id: @user.id, instrument_id: instrument.id)
        render json: {instrument: {id: instrument.id, name: instrument.name}}
    end 
    def delete
        @user = User.find(params[:user_id])
        user_instrument = Userinstrument.find_by(user_id: @user.id, instrument_id: params[:instrument_id])
        user_instrument.destroy
        render json: {message: 'instrument deleted.'}
    end
end
