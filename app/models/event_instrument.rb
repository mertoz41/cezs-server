class EventInstrument < ApplicationRecord
    belongs_to :instrument
    belongs_to :event
end
