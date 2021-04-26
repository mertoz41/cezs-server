class Instrument < ApplicationRecord
    has_many :userinstruments
    has_many :users, through: :userinstruments
    
    has_many :posts
    has_many :userdescposts

    has_many :bandpostinstruments
    has_many :bandposts, through: :bandpostinstruments

    has_many :banddescpostinstruments
    has_many :banddescposts, through: :banddescpostinstruments
end
