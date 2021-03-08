class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :created_at, :avatar, :follows, :followed_by, :location, :artists, :instruments
  attribute :avatar, if: -> {object.avatar.present?}
  attribute :bio, if: -> {object.bio}

  def created_at
    object.created_at.to_date
  end

  def avatar
    return url_for(object.avatar)
  end
  def bio 
    return object.bio.description
  end

end
