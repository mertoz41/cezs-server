class Genre < ApplicationRecord
    has_many :posts
    has_many :event_genres, dependent: :destroy
    has_many :events, through: :event_genres

    has_many :usergenres, dependent: :destroy
    has_many :users, through: :usergenres

    has_many :bandgenres, dependent: :destroy
    has_many :bands, through: :bandgenres
    # BUSINESS LOGIC MUST BE MOVED TO MODELS

end
