class Request < ApplicationRecord
    belongs_to :user
    belongs_to :artist
    belongs_to :song
    has_many :responses, dependent: :destroy
end
