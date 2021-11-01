class ApplaudNotification < ApplicationRecord
    belongs_to :user
    belongs_to :applauding_user, class_name: 'User', foreign_key: :action_user_id
    belongs_to :applaud
end
