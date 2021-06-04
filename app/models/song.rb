class Song < ApplicationRecord
    belongs_to :artist

    has_many :posts, dependent: :destroy
    has_many :requests, dependent: :destroy
    has_many :bandposts
    has_many :bands, through: :bandposts

    has_many :users, through: :posts

    has_many :usersongs, dependent: :destroy
    has_many :favoriteusers, through: :usersongs
end
