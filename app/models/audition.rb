class Audition < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :band, optional: true
    has_one :audition_location, dependent: :destroy
    has_one :location, through: :audition_location

    has_many :audition_instruments, dependent: :destroy
    has_many :instruments, through: :audition_instruments

    has_many :audition_genres, dependent: :destroy
    has_many :genres, through: :audition_genres
end
