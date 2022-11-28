class Post < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
    has_many :comments, dependent: :destroy

    has_many :applauds, dependent: :destroy
    has_many :applauding_users, through: :applauds
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

    has_many :notifications, dependent: :destroy
    has_many :post_reports, dependent: :destroy


end
