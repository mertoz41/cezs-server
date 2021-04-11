class Artist < ApplicationRecord
    has_many :songs, dependent: :destroy
    has_many :posts, dependent: :destroy
    # has_many :requests, dependent: :destroy
    has_many :bandposts

    has_many :userinfluences
    has_many :users, through: :userinfluences

    has_many :artistfollows, dependent: :destroy
    has_many :followingusers, through: :artistfollows


end
