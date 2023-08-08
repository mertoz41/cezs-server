class Post < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["artist_id", "band_id", "created_at", "description", "genre_id", "id", "song_id", "updated_at", "user_id"]
      end
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

    has_many :reports, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        column_names + _ransackers.keys
      end
    
      def self.ransackable_associations(auth_object = nil)
        reflect_on_all_associations.map { |a| a.name.to_s } + _ransackers.keys
      end
end
