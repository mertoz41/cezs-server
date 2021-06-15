class Userdescpostfeature < ApplicationRecord
    belongs_to :featureduser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :featureduserdescpost, class_name: 'Userdescpost', foreign_key: 'userdescpost_id'
end
