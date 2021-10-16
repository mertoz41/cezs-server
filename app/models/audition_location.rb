class AuditionLocation < ApplicationRecord
    belongs_to :location
    belongs_to :audition
end
