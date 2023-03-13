class Band < ApplicationRecord
    has_one_attached :picture
    has_many :bandmembers, dependent: :destroy
    has_many :members, through: :bandmembers

    has_one :notification, dependent: :destroy
    has_one :bandlocation, dependent: :destroy
    has_one :location, through: :bandlocation
    has_many :reports, dependent: :destroy

    has_many :posts, dependent: :destroy
    has_many :songs, through: :posts

    has_many :bandfollows, dependent: :destroy
    has_many :followers, through: :bandfollows

    has_many :events, dependent: :destroy

    has_many :bandgenres, dependent: :destroy
    has_many :genres, through: :bandgenres


end
