class UserblocksController < ApplicationController
    def create
        new_block = UserBlock.create(blocked_id: params[:user_id], blocking_id: logged_in_user.id)
        # check if user follows blocked user, if so delete follow
        render json: {message: 'user blocked.'}
    end
    def blockedaccounts
        @users = logged_in_user.blocked_users
        @bands = logged_in_user.blocked_bands
        render json: { users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: ShortUserSerializer),
        bands: ActiveModel::Serializer::CollectionSerializer.new(@bands, each_serializer: ShortBandSerializer)
        }
    end
    def unblockuser
        userblock = UserBlock.find_by(blocked_id: params[:id], blocking_id: logged_in_user.id)
        userblock.destroy
        render json: {message: 'user unblocked'}
    end

    def blockband
        new_block = BandBlock.create(band_id: params[:band_id], user_id: logged_in_user.id)
        render json: {message: 'band blocked.'}
    end
    
end
