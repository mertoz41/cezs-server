class Band < ApplicationRecord
    has_one_attached :picture

    has_many :bandmembers, dependent: :destroy
    has_many :members, through: :bandmembers

    has_many :bandlocations, dependent: :destroy
    has_many :locations, through: :bandlocations

end
