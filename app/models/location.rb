class Location < ApplicationRecord
    # belongs_to :user
    has_many :userlocations
    has_many :users, through: :userlocations

    has_many :bandlocations
    has_many :bands, through: :bandlocations
end
