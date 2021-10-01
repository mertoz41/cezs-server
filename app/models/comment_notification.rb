class CommentNotification < ApplicationRecord
    belongs_to :user, optional: true
    # belongs_to :band, optional: true
    belongs_to :post
end
