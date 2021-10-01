class EventNotification < ApplicationRecord
    belongs_to :user
    belongs_to :performing_user, class_name: 'User', foreign_key: :action_user_id, optional: true
    belongs_to :performing_band, class_name: 'Band', foreign_key: :action_band_id, optional: true
    belongs_to :event
end
