class ShareNotification < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :share
end
