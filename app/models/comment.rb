class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :reports, dependent: :destroy
    has_one :notification, dependent: :destroy
end
