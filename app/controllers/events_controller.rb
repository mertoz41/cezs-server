class EventsController < ApplicationController
    def index
        all_events = Event.where('event_date >= ?', Date.today)
        @events = all_events.select{|gig| !blokes.include?(gig.user_id)}.select{|gig| !band_blokes.include?(gig.band_id)}
        render json: {events: ActiveModel::Serializer::CollectionSerializer.new(@events, each_serializer: EventSerializer)}
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
        # all_state_users = User.joins(:location).where('city like?', "%#{params[:address].split().last}%")

        # users_by_state = all_state_users.select do |user|
        #     user.id != params[:user_id]
        # end
       
        # users_by_state.each do |user|
        #     @new_noti = EventNotification.create(event_id: @event.id, action_user_id: params[:user_id], user_id: user.id, seen: false)
        #     if user.notification_token
        #         SendNotificationJob.perform_later(
        #             user.notification_token.token,
        #             "#{@event.user.username} has an upcoming gig!",
        #             EventNotificationSerializer.new(@new_noti).as_json
        #         )
              
        #     end
        # end

        # find location from the end of params[:address]
        # get users that are in that location
        # send notis to those users
        render json: {event: EventSerializer.new(@event)}
    end

    
end
