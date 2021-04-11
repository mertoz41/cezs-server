class Artistfollow < ApplicationRecord
    belongs_to :followinguser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :followedartist, class_name: 'Artist', foreign_key: 'artist_id'
end
