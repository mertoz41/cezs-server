class UsereventsController < ApplicationController
    def index
        today_date = Time.now
        @user_events = Userevent.where("event_date >= :date", date: today_date.tomorrow.beginning_of_day)
        @band_events = Bandevent.where("event_date >= :date", date: today_date.tomorrow.beginning_of_day)
        render json: {user_events: ActiveModel::Serializer::CollectionSerializer.new(@user_events, each_serializer: UsereventSerializer), band_events: ActiveModel::Serializer::CollectionSerializer.new(@band_events, each_serializer: BandeventSerializer)}
    end
    
    def create
        @event = Userevent.create(address: params[:address], 
        description: params[:description], 
        user_id: params[:user_id], 
        latitude: params[:latitude], 
        longitude: params[:longitude],
        event_date: params[:event_date],
        event_time: params[:event_time]
        )
        render json: {event: UsereventSerializer.new(@event)}
    end


end
