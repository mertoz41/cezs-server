class Band < ApplicationRecord
    has_one_attached :picture

    has_many :bandmembers, dependent: :destroy
    has_many :users, through: :bandmembers

    has_one :bandlocation
    has_one :location, through: :bandlocation

    has_many :bandposts

end
