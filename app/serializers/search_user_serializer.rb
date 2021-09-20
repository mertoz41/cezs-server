class SearchUserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :username, :avatar
  attribute :avatar, if: -> {object.avatar.present?}
  def avatar
    return url_for(object.avatar)
  end
end
