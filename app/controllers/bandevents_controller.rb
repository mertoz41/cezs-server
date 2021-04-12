class BandeventsController < ApplicationController
    def create
        @event = Bandevent.create(address: params[:address], 
        description: params[:description], 
        band_id: params[:band_id], 
        latitude: params[:latitude], 
        longitude: params[:longitude],
        event_date: params[:event_date]
        )
        render json: {event: BandeventSerializer.new(@event)}
    end
end
