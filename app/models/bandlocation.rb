class Bandlocation < ApplicationRecord
    belongs_to :band
    belongs_to :location
end
