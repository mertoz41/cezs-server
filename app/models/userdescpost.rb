class Userdescpost < ApplicationRecord
    has_one_attached :clip
    belongs_to :user
    belongs_to :instrument
end
