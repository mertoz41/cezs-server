class AuditionsController < ApplicationController
    def locationauditions
        location = Location.find(params[:id])
        @auditions = location.auditions.where('audition_date >= ?', Date.today)
        render json: {auditions: ActiveModel::Serializer::CollectionSerializer.new(@auditions, each_serializer: AuditionSerializer)}
    end

    def createuseraudition
        @audition = Audition.create(
            description: params[:description],
            user_id: params[:user_id],
            audition_date: params[:audition_date],
        )
        audit_location = AuditionLocation.create(audition_id: @audition.id, location_id: params[:location_id])
        if params[:instruments].length > 0
            params[:instruments].each do |inst|
                instrument = Instrument.find_or_create_by(name: inst)
                AuditionInstrument.create(instrument_id: instrument.id, audition_id: @audition.id)
            end
        end
        if params[:genres].length > 0
            params[:genres].each do |genr|
                genre = Genre.find_or_create_by(name: genr)
                AuditionGenre.create(genre_id: genre.id, audition_id: @audition.id)
            end
        end
        # handle notifications
        all_state_users = Location.find(params[:location_id]).users
        users_by_state = all_state_users.select do |user|
            user.id != params[:user_id]
        end

        users_by_state.each do |user|
            @new_noti = AuditionNotification.create(audition_id: @audition.id, action_user_id: params[:user_id], user_id: user.id, seen: false)
            if user.notification_token
                SendNotificationJob.perform_later(
                    user.notification_token.token,
                    "#{User.find(params[:user_id]).username} has an upcoming audition!",
                    AuditionNotificationSerializer.new(@new_noti).as_json
                )
            end
        end

        render json: {location: LocationSerializer.new(@audition.location), audition: AuditionSerializer.new(@audition)}
    end

    def createbandaudition
        @audition = Audition.create(
            description: params[:description],
            band_id: params[:band_id],
            audition_date: params[:audition_date],
        )
        audit_location = AuditionLocation.create(audition_id: @audition.id, location_id: params[:location_id])
        if params[:instruments].length > 0
            params[:instruments].each do |inst|
                instrument = Instrument.find_or_create_by(name: inst)

                AuditionInstrument.create(instrument_id: instrument.id, audition_id: @audition.id)
            end
        end
        if params[:genres].length > 0
            params[:genres].each do |genr|
                genre = Genre.find_or_create_by(name: genr)
                AuditionGenre.create(genre_id: genre.id, audition_id: @audition.id)
            end
        end        
        users_by_state = Location.find(params[:location_id]).users
        users_by_state.each do |user|
            @new_noti = AuditionNotification.create(audition_id: @audition.id, action_band_id: params[:band_id], user_id: user.id, seen: false)
            if user.notification_token
                SendNotificationJob.perform_later(
                    user.notification_token.token,
                    "#{Band.find(params[:band_id]).name} has an upcoming audition!",
                    AuditionNotificationSerializer.new(@new_noti).as_json
                )
   
            end
        end
        render json: @audition.location, serializer: LocationSerializer
    end

    
    
end
