class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :last_message, :users
  include Rails.application.routes.url_helpers

  def users
    object.users.map do |user|
      obj = {id: user.id, username: user.username}
      if user.avatar.attached?
        obj["avatar"] = "#{ENV['CLOUDFRONT_API']}/#{user.avatar.key}"
      end
      obj
    end
  end

  def last_message
    if object.messages.size > 0
      return object.messages.last
    end
  end

end
