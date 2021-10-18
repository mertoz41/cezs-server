class AuditionNotification < ApplicationRecord
    belongs_to :user
    belongs_to :auditing_user, class_name: 'User', foreign_key: :action_user_id, optional: true
    belongs_to :auditing_band, class_name: 'Band', foreign_key: :action_band_id, optional: true
    belongs_to :audition
end
