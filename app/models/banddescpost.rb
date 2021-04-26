class Banddescpost < ApplicationRecord
    has_one_attached :clip
    belongs_to :band
    has_many :banddescpostinstruments, dependent: :destroy
    has_many :instruments, through: :banddescpostinstruments
    has_many :banddescpostcomments, dependent: :destroy
end
