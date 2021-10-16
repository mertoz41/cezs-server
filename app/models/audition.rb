class Audition < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :band, optional: true
    has_one :audition_location, dependent: :destroy
    has_one :location, through: :audition_location
end
