class Song < ApplicationRecord
    belongs_to :artist
    belongs_to :album


    # old version 
    has_many :posts, dependent: :destroy
    has_many :users, through: :posts

    has_many :bands, through: :posts

    has_many :requests, dependent: :destroy
    # has_many :bandposts, dependent: :destroy
    # has_many :bands, through: :bandposts

    
    has_many :usersongs, dependent: :destroy
    has_many :favoriteusers, through: :usersongs

    has_many :songfollows, dependent: :destroy
    has_many :followingusers, through: :songfollows
end
