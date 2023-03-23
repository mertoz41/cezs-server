class Notification < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :action_user, class_name: 'User', foreign_key: :action_user_id, optional: true
    belongs_to :band, optional: true
    belongs_to :comment, optional: true
    belongs_to :event, optional: true
    belongs_to :applaud, optional: true
    belongs_to :bandfollow, optional: true
end
