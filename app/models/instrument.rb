class Instrument < ApplicationRecord
    has_many :userinstruments
    has_many :users, through: :userinstruments
    
    has_many :posts

    has_many :bandpostinstruments
    has_many :bandposts, through: :bandpostinstruments
end
