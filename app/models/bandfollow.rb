class Bandfollow < ApplicationRecord
    belongs_to :user
    belongs_to :followedband, class_name: 'Band', foreign_key: 'band_id'
end
