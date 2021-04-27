class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar

    has_many :userinfluences
    has_many :artists, through: :userinfluences
    
    # has_and_belongs_to_many :chatrooms, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :userchatrooms, dependent: :destroy
    has_many :chatrooms, through: :userchatrooms

    has_many :userevents, dependent: :destroy


    has_many :bandfollows, dependent: :destroy
    has_many :followedbands, through: :bandfollows

    has_many :artistfollows, dependent: :destroy
    has_many :followedartists, through: :artistfollows


    validates :username, uniqueness: { case_sensitive: false }
    # has_one :location
    has_one :bio, dependent: :destroy
    has_one :userlocation, dependent: :destroy
    has_one :location, through: :userlocation

    has_many :bandmembers, dependent: :destroy
    has_many :bands, through: :bandmembers

    has_many :posts, dependent: :destroy
    has_many :songs, through: :posts

    has_many :comments, dependent: :destroy

    has_many :bandpostcomments, dependent: :destroy
    has_many :userdescpostcomments, dependent: :destroy
    has_many :banddescpostcomments, dependent: :destroy




    has_many :shares, dependent: :destroy
    has_many :bandpostshares, dependent: :destroy
    has_many :banddescpostshares, dependent: :destroy
    has_many :userdescpostshares, dependent: :destroy

    # has_many :requests, dependent: :destroy
    # has_many :responses, dependent: :destroy
    has_many :userdescposts, dependent: :destroy

    has_many :userinstruments, dependent: :destroy
    has_many :instruments, through: :userinstruments

    has_many :followed_by, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :followed_by, source: :follower
    has_many :follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
    has_many :followeds, through: :follows, source: :followed
end
