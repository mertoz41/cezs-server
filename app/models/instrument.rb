class Instrument < ApplicationRecord
    has_many :userinstruments
    has_many :users, through: :userinstruments
    
    has_many :postinstruments
    has_many :posts, through: :postinstruments 
    
    has_many :eventinstruments
    has_many :events, through: :eventinstruments
end
