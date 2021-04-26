class Bandpostcomment < ApplicationRecord
    belongs_to :user
    belongs_to :bandpost
end
