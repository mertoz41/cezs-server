class Userartist < ApplicationRecord
    belongs_to :favoriteartist, class_name: 'Artist', foreign_key: 'artist_id'
    belongs_to :favoriteusers, class_name: 'User', foreign_key: 'user_id'
end
