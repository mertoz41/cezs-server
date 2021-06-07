class Album < ApplicationRecord
    belongs_to :artist
    has_many :songs, dependent: :destroy
    # has_many :posts, through: :songs
    # has_many :bandposts, through: :songs
end
