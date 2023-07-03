class EventsController < ApplicationController
    def index
        all_events = Event.where('event_date >= ?', Date.today)
        events = []
        if logged_in_user.blocked_users.size || logged_in_user.blocked_bands.size || logged_in_user.blocking_users.size
            events = filter_blocked_posts(all_events)
        else
            events = all_events
        end
        events = events.select{|event| event.reports.size < 1}
        render json: {events: ActiveModel::Serializer::CollectionSerializer.new(events, each_serializer: EventSerializer)}
    end
    
    def show
        @event = Event.find(params[:id])
        render json: @event, serializer: EventSerializer
    end

    def create
        @event = Event.create(address: params[:address], 
        description: params[:description], 
        user_id: params[:userId],
        band_id: params[:bandId],
        latitude: params[:latitude], 
        longitude: params[:longitude],
        event_date: params[:eventDate],
        event_time: params[:eventTime],
        is_audition: params[:isAudition]
        )
        if params[:instruments].length > 0
            params[:instruments].each do |inst|
                instrument = Instrument.find_or_create_by(name: inst)
                EventInstrument.create(instrument_id: instrument.id, event_id: @event.id)
            end
        end
        if params[:genres].length > 0
            params[:genres].each do |genr|
                genre = Genre.find_or_create_by(name: genr)
                EventGenre.create(genre_id: genre.id, event_id: @event.id)
            end
        end

        render json: {event: EventSerializer.new(@event)}
    end

    def destroy 
        event = Event.find(params[:id])
        event.destroy
        render json: {message: "event deleted."}
    end

    
end
