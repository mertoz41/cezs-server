class InstrumentsController < ApplicationController
    def index
        @instruments = Instrument.all
        render json: {instruments: ActiveModel::Serializer::CollectionSerializer.new(@instruments, each_serializer: InstrumentSerializer)}
    end
    def searching
        instruments = Instrument.where('name like?', "%#{params[:searching]}%")
        render json: {instruments: instruments.as_json(:except => [:created_at, :updated_at])}
    end 
    def filter
        instruments = Instrument.where(id: params[:selected_instruments])
        @users = []
        instruments.each do |inst|
            @users = @users + inst.users
        end
        render json: {users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: UserSerializer)}
    end

    def instrumentsearch
        instruments = Instrument.where("name like?", "%#{params[:searching]}%")
        render json: {instruments: instruments}
        # byebug
    end
end
