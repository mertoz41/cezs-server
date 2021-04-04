class Bandpost < ApplicationRecord
    has_one_attached :clip
    
    belongs_to :band
    belongs_to :song
    belongs_to :artist

end
