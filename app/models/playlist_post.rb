class PlaylistPost < ApplicationRecord
    belongs_to :post
    belongs_to :playlist
end
