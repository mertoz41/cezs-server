class Report < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :band, optional: true
    belongs_to :post, optional: true
    belongs_to :comment, optional: true
    belongs_to :event, optional: true

end
