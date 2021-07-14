class Songfollow < ApplicationRecord
    belongs_to :followinguser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :followedsong, class_name: 'Song', foreign_key: 'song_id'
end
