class Event < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :band, optional: true

    has_many :eventinstruments, dependent: :destroy
    has_many :instruments, through: :eventinstruments
end
