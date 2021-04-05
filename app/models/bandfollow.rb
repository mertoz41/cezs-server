class Bandfollow < ApplicationRecord
    belongs_to :user
    belongs_to :band
end
