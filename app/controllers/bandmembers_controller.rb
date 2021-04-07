class BandmembersController < ApplicationController
    def removemember
        band_member_instance = Bandmember.find_by(user_id: params[:member_id], band_id: params[:band_id])
        band_member_instance.destroy
        render json: {message: 'succezs'}
    end
end
