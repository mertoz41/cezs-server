class AuditionsController < ApplicationController

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
        render json: {message: 'audition created'}
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
        # handle notifications
        render json: {message: 'audition created'}

    end
    
end
