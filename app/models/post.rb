class Post < ApplicationRecord
    has_one_attached :clip
    has_many :comments, dependent: :destroy
    has_many :shares, dependent: :destroy 
    belongs_to :user
    belongs_to :instrument
    belongs_to :genre
    belongs_to :artist
    belongs_to :song

    has_many :postfeatures, dependent: :destroy
    has_many :featuredusers, through: :postfeatures
end
