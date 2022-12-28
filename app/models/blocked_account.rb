class BlockedAccount < ApplicationRecord
    belongs_to :blocked_user, class_name: "User", foreign_key: :blocked_user_id, optional: true
    belongs_to :blocked_band, class_name: "Band", foreign_key: :blocked_band_id, optional: true
    belongs_to :blocking_user, class_name: "User", foreign_key: :blocking_user_id
end
