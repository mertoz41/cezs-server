class Song < ApplicationRecord
    belongs_to :artist
    has_many :posts, dependent: :destroy
    has_many :requests, dependent: :destroy
    has_many :bandposts

    has_many :users, through: :posts
end
