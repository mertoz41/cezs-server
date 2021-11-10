class EventsController < ApplicationController
    def index
        @events = Event.where('event_date >= ?', Date.today)
        render json: {events: ActiveModel::Serializer::CollectionSerializer.new(@events, each_serializer: EventSerializer)}
    end
    def show
        @event = Event.find(params[:id])
        render json: @event, serializer: EventSerializer
    end
    def bandevent
        @event = Event.create(address: params[:address], 
        description: params[:description], 
        band_id: params[:band_id], 
        latitude: params[:latitude], 
        longitude: params[:longitude],
        event_date: params[:event_date],
        event_time: params[:event_time]
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
        users_by_state = User.joins(:location).where('city like?', "%#{params[:address].split().last}%")

        band = Band.find(params[:band_id])
        users_by_state.each do |user|
            @new_noti = EventNotification.create(event_id: @event.id, action_band_id: params[:band_id], user_id: user.id, seen: false)
            if user.notification_token
                SendNotificationJob.perform_later(
                    user.notification_token.token,
                    "#{band.name} has an upcoming gig!",
                    EventNotificationSerializer.new(@new_noti).as_json
                )
            end
        end
        render json: {event: EventSerializer.new(@event)}
    end

    def userevent
        @event = Event.create(address: params[:address], 
        description: params[:description], 
        user_id: params[:user_id], 
        latitude: params[:latitude], 
        longitude: params[:longitude],
        event_date: params[:event_date],
        event_time: params[:event_time]
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
        all_state_users = User.joins(:location).where('city like?', "%#{params[:address].split().last}%")

        users_by_state = all_state_users.select do |user|
            user.id != params[:user_id]
        end
       
        users_by_state.each do |user|
            @new_noti = EventNotification.create(event_id: @event.id, action_user_id: params[:user_id], user_id: user.id, seen: false)
            if user.notification_token
                SendNotificationJob.perform_later(
                    user.notification_token.token,
                    "#{@event.user.username} has an upcoming gig!",
                    EventNotificationSerializer.new(@new_noti).as_json
                )
              
            end
        end

        # find location from the end of params[:address]
        # get users that are in that location
        # send notis to those users
        render json: {event: EventSerializer.new(@event)}
    end

    
end
