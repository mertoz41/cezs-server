class Band < ApplicationRecord
    has_one_attached :picture

    has_many :bandmembers, dependent: :destroy
    has_many :members, through: :bandmembers

    
end
