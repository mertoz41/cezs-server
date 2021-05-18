class Userdescpost < ApplicationRecord
    has_one_attached :clip
    belongs_to :user
    belongs_to :genre
    belongs_to :instrument
    has_many :userdescpostcomments, dependent: :destroy
    has_many :userdescpostshares, dependent: :destroy
end
