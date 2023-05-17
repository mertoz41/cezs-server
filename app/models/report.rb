class Report < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :reporting_user, class_name: "User", foreign_key: :reporting_user_id
    belongs_to :band, optional: true
    belongs_to :post, optional: true
    belongs_to :comment, optional: true
    belongs_to :event, optional: true

end
