class BandmembersController < ApplicationController
    def removemember
        band_member_instance = Bandmember.find_by(user_id: params[:member_id], band_id: params[:band_id])
        band_member_instance.destroy
        render json: {message: 'succezs'}
    end

    def create 
        band = Band.find(params[:band_id])
        @user = User.find(params[:user_id])
        new_band_member = Bandmember.create({user_id: @user.id, band_id: band.id})
        render json: {member: UserSerializer.new(@user)}
    end
end
