class Playlist < ApplicationRecord
    belongs_to :user
    has_many :playlist_posts, dependent: :destroy
    has_many :posts, through: :playlist_posts
end
