class Banddescpost < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
    belongs_to :band
    belongs_to :genre
    has_many :banddescpostinstruments, dependent: :destroy
    has_many :instruments, through: :banddescpostinstruments
    has_many :banddescpostcomments, dependent: :destroy
    has_many :banddescpostshares, dependent: :destroy
    has_many :banddescpostviews, dependent: :destroy
end
