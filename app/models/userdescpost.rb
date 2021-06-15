class Userdescpost < ApplicationRecord
    has_one_attached :clip
    belongs_to :user
    belongs_to :genre
    has_many :userdescpostinstruments, dependent: :destroy
    has_many :instruments, through: :userdescpostinstruments
    # belongs_to :instrument
    has_many :userdescpostcomments, dependent: :destroy
    has_many :userdescpostshares, dependent: :destroy

    has_many :userdescpostfeatures, dependent: :destroy
    has_many :featuredusers, through: :userdescpostfeatures
end
