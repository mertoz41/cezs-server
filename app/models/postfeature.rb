class Postfeature < ApplicationRecord
    belongs_to :featureduser, class_name: 'User', foreign_key: 'user_id'
    belongs_to :featuredsong, class_name: 'Post', foreign_key: 'post_id'
end
