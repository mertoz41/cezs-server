class Instrument < ApplicationRecord
    has_many :userinstruments
    has_many :users, through: :userinstruments
    
    has_many :postinstruments
    has_many :posts, through: :postinstruments 
    
    has_many :event_instruments
    has_many :events, through: :event_instruments

end
