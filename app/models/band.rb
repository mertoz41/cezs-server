class Band < ApplicationRecord
    has_one_attached :picture
    has_many :share_notifications, dependent: :destroy
    has_many :bandmembers, dependent: :destroy
    has_many :members, through: :bandmembers

    has_many :band_blocks, dependent: :destroy
    has_many :blocking_users, through: :band_blocks
    # has_many :share_notifications, dependent: :destroy
    # has_many :comment_notifications, dependent: :destroy
    has_many :follow_notifications, dependent: :destroy
    has_many :event_notifications, dependent: :destroy


    has_one :bandlocation, dependent: :destroy
    has_one :location, through: :bandlocation
    has_many :auditions, dependent: :destroy

    # has_many :bandposts, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :songs, through: :posts

    has_many :bandfollows, dependent: :destroy
    has_many :followers, through: :bandfollows

    has_one :bandbio, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :banddescposts, dependent: :destroy

    has_many :bandgenres, dependent: :destroy
    has_many :genres, through: :bandgenres


end
