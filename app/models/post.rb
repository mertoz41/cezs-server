class Post < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
    has_many :comments, dependent: :destroy
    has_many :comment_notifications, dependent: :destroy
    has_many :shares, dependent: :destroy 
    # old version to be updated with optional
    belongs_to :user, optional: true
    belongs_to :band, optional: true
    has_many :postinstruments, dependent: :destroy
    has_many :instruments, through: :postinstruments
    # belongs_to :instrument
    belongs_to :genre
    belongs_to :artist, optional: true
    belongs_to :song, optional: true
    has_many :postviews, dependent: :destroy
    has_many :postfeatures, dependent: :destroy
    has_many :featuredusers, through: :postfeatures

    has_many :playlist_posts, dependent: :destroy
    has_many :playlists, through: :playlist_posts


end
