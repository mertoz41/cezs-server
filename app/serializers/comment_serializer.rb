class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user_id, :integer, :post_id
end
