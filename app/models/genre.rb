class Genre < ApplicationRecord
    has_many :posts
    has_many :event_genres, dependent: :destroy
    has_many :events, through: :event_genres
end
