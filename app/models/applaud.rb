class Applaud < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :applaud_notifications, dependent: :destroy
end
