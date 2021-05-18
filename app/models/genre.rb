class Genre < ApplicationRecord
    has_many :posts
    has_many :bandposts
    has_many :userdescposts
    has_many :banddescposts
end
