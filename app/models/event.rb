class Event < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :band, optional: true

    has_many :event_instruments, dependent: :destroy
    has_many :instruments, through: :event_instruments
end
