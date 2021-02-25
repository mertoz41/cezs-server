class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :follows, :followed_by
  attribute :avatar, if: -> {object.avatar.present?}

  def created_at
    object.created_at.to_date
  end

  def avatar
    return url_for(object.avatar)
  end 

end
