class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    
    validates :username, uniqueness: { case_sensitive: false }
    # has_one :location
    has_one :userlocation
    has_one :location, through: :userlocation

    has_many :posts, dependent: :destroy
    has_many :genres, through: :posts

    has_many :comments, dependent: :destroy
    has_many :shares, dependent: :destroy

    has_many :requests, dependent: :destroy
    has_many :responses, dependent: :destroy

    has_many :userinstruments, dependent: :destroy
    has_many :instruments, through: :userinstruments

    has_many :followed_by, class_name: "Follow", foreign_key: :followed_id
    has_many :followers, through: :followed_by, source: :follower
    has_many :follows, class_name: "Follow", foreign_key: :follower_id
    has_many :followeds, through: :follows, source: :followed
end
