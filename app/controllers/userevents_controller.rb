class UsereventsController < ApplicationController
    def index
        @events = Userevent.all
        render json: {events: ActiveModel::Serializer::CollectionSerializer.new(@events, each_serializer: UsereventSerializer)}
    end
    
    def create
        @event = Userevent.create(address: params[:address], 
        description: params[:description], 
        user_id: params[:user_id], 
        latitude: params[:latitude], 
        longitude: params[:longitude],
        event_date: params[:event_date]
        )
        render json: {event: UsereventSerializer.new(@event)}
    end

end
