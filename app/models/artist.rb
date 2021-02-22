class Artist < ApplicationRecord
    has_many :songs, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :requests, dependent: :destroy
end
