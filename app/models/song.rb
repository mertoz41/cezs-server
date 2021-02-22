class Song < ApplicationRecord
    belongs_to :artist
    has_many :posts, dependent: :destroy
    has_many :requests, dependent: :destroy
end
