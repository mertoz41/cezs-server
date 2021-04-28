class UserdescpostshareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :description, :username, :user_avatar
  def clip 
    userdescpost = object.userdescpost
    return url_for(userdescpost.clip)
  end 
  def description
    userdescpost = object.userdescpost
    return userdescpost.description
  end
  def username
    userdescpost = object.userdescpost
    return userdescpost.user.username
  end
  def user_avatar 
    userdescpost = object.userdescpost
    return url_for(userdescpost.user.avatar)
  end


end
