class Share < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_one :share_notification, dependent: :destroy
end
