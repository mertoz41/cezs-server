class Usersong < ApplicationRecord
    belongs_to :favoriteuser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :favoritesong, class_name: 'Song', foreign_key: 'song_id'
end
