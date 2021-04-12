class Band < ApplicationRecord
    has_one_attached :picture

    has_many :bandmembers, dependent: :destroy
    has_many :members, through: :bandmembers

    has_one :bandlocation, dependent: :destroy
    has_one :location, through: :bandlocation

    has_many :bandposts, dependent: :destroy

    has_many :bandfollows, dependent: :destroy
    has_many :users, through: :bandfollows

    has_one :bandbio, dependent: :destroy

    has_many :bandevents, dependent: :destroy


end
