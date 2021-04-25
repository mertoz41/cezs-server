class Banddescpost < ApplicationRecord
    has_one_attached :clip
    belongs_to :band
end
