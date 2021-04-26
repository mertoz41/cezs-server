class Userdescpostcomment < ApplicationRecord
    belongs_to :user
    belongs_to :userdescpost 
end
