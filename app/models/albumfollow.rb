class Albumfollow < ApplicationRecord
    belongs_to :followinguser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :followedalbum, class_name: 'Album', foreign_key: 'album_id'
end
