class UsereventsController < ApplicationController
    def index
        @user_events = Userevent.all
        @band_events = Bandevent.all
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

    # def bydate
    #     @user_events = Userevent.where("event_date like?", "%#{params[:date]}%")
    #     @band_events = Bandevent.where("event_date like?", "%#{params[:date]}%")
    #     render json: {user_events: ActiveModel::Serializer::CollectionSerializer.new(@user_events, each_serializer: UsereventSerializer), band_events: ActiveModel::Serializer::CollectionSerializer.new(@band_events, each_serializer: BandeventSerializer)}
    # end

end
