class UserblocksController < ApplicationController
    def create
        new_block = BlockedAccount.create(
            blocked_user_id: params[:blocked_user_id], 
            blocked_band_id: params[:blocked_band_id], 
            blocking_user_id: logged_in_user.id
            )
        render json: {message: 'user blocked.'}
    end
    def index
        @users = logged_in_user.blocked_users
        @bands = logged_in_user.blocked_bands
        render json: { users: ActiveModel::Serializer::CollectionSerializer.new(@users, each_serializer: ShortUserSerializer),
        bands: ActiveModel::Serializer::CollectionSerializer.new(@bands, each_serializer: ShortBandSerializer)
        }
    end
    def delete
        userblock = BlockedAccount.find_by(blocked_user_id: params[:id], blocking_user_id: logged_in_user.id)
        userblock.destroy
        render json: {message: 'user unblocked.'}
    end
    def unblockband
        bandblock = BlockedAccount.find_by(blocked_band_id: params[:id], blocking_user_id: logged_in_user.id)
        bandblock.destroy
        render json: {message: 'band unblocked.'}
    end
    
end
