class Userdescpost < ApplicationRecord
    has_one_attached :clip
    belongs_to :user
    belongs_to :instrument
    has_many :userdescpostcomments, dependent: :destroy
end
