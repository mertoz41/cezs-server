class EventsController < ApplicationController
    def index
        @events = Event.where('event_date >= ?', Date.today)
        render json: {events: ActiveModel::Serializer::CollectionSerializer.new(@events, each_serializer: EventSerializer)}
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
        users_by_state = User.joins(:location).where('city like?', "%#{params[:address].split().last}%")
        messages = []
        client = Exponent::Push::Client.new

        users_by_state.each do |user|
            @new_noti = EventNotification.create(event_id: @event.id, action_user_id: params[:user_id], user_id: user.id, seen: false)
            if user.notification_token
                obj = {to: user.notification_token.token,
                        body: "#{@event.user.username} has an upcoming gig!",
                        data: EventNotificationSerializer.new(@new_noti)
                }
                messages.push(obj)
            end
        end
        handler = client.send_messages(messages)

        # find location from the end of params[:address]
        # get users that are in that location
        # send notis to those users
        render json: {event: EventSerializer.new(@event)}
    end
end
