class Useralbum < ApplicationRecord
    belongs_to :favoriteuser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :favoritealbum, class_name: 'Album', foreign_key: 'album_id'
end
