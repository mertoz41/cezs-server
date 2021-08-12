class Post < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
    has_many :comments, dependent: :destroy
    has_many :shares, dependent: :destroy 
    belongs_to :user
    belongs_to :band
    has_many :postinstruments, dependent: :destroy
    has_many :instruments, through: :postinstruments
    # belongs_to :instrument
    belongs_to :genre
    belongs_to :artist
    belongs_to :song
    has_many :postviews, dependent: :destroy
    has_many :postfeatures, dependent: :destroy
    has_many :featuredusers, through: :postfeatures

    # after_initialize :default_values


    # private
    #     def default_values
    #         self.user_id = nil if self.user_id.nil?
    #         self.band_id = nil if self.band_id.nil?
    #         self.description = nil if self.description.nil?
    #         self.song_id = nil if self.song_id.nil?
    #         self.artist_id = nil if self.artist_id.nil?
    #     end
end
