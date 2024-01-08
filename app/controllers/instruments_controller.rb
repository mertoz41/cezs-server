class InstrumentsController < ApplicationController
    def index
        @instruments = Instrument.all
        render json: {instruments: ActiveModel::Serializer::CollectionSerializer.new(@instruments, each_serializer: InstrumentSerializer)}
    end
    def searching
        instruments = Instrument.where('name like?', "%#{params[:searching]}%")
        render json: {instruments: instruments.as_json(:except => [:created_at, :updated_at])}
    end 

end
