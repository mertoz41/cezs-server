class Artist < ApplicationRecord
    has_many :songs, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :postviews, through: :posts
    has_many :albums, dependent: :destroy
    

    has_many :artistfollows, dependent: :destroy
    has_many :followingusers, through: :artistfollows

    has_many :userartists, dependent: :destroy
    has_many :favoriteusers, through: :userartists

    


end
