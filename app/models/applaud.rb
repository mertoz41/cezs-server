class Applaud < ApplicationRecord
    belongs_to :applauding_user, class_name: "User", foreign_key: 'user_id'
    belongs_to :post
    has_many :notifications, dependent: :destroy
end
