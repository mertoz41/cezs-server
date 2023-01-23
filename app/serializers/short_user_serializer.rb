class ShortUserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :location, :instruments, :genres, :name
  attribute :avatar, if: -> {object.avatar.present?}

  def instruments
    object.instruments.map do |inst|
      {id: inst.id, name: inst.name}
    end
  end
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end
  def avatar
    return url_for(object.avatar)
  end

end
