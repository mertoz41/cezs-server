class Userinfluence < ApplicationRecord
    belongs_to :influenceduser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :influencer, class_name: 'Artist', foreign_key: 'artist_id'
end
