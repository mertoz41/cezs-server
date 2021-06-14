class Postinstrument < ApplicationRecord
    belongs_to :post
    belongs_to :instrument
end
