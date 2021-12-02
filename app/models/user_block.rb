class UserBlock < ApplicationRecord
    belongs_to :blockeduser, class_name: 'User', foreign_key: :blocked_id
    belongs_to :blockinguser, class_name: 'User', foreign_key: :blocking_id
end
