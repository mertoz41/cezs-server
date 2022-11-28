class Event < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :band, optional: true

    has_many :event_instruments, dependent: :destroy
    has_many :instruments, through: :event_instruments

    has_many :event_genres, dependent: :destroy
    has_many :genres, through: :event_genres

    has_many :notifications, dependent: :destroy
end
