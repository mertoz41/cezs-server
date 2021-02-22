class ShareSerializer < ActiveModel::Serializer
  attributes :id, :post_id, :user_id, :integer
end
