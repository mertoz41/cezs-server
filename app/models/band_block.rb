class BandBlock < ApplicationRecord
    belongs_to :blocked_band, class_name: 'Band', foreign_key: 'band_id'
    belongs_to :blocking_user, class_name: 'User', foreign_key: 'user_id'
end
