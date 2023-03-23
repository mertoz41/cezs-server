class Bandfollow < ApplicationRecord
    belongs_to :follower, class_name: 'User', foreign_key: 'user_id'
    belongs_to :followedband, class_name: 'Band', foreign_key: 'band_id'
    has_many :notifications, dependent: :destroy
end
