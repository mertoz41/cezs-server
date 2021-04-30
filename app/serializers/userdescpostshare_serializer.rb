class UserdescpostshareSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :clip, :description, :username, :useravatar, :created_at, :share_count, :user_id, :comment_count, :userdescpost_id
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
  def useravatar 
    userdescpost = object.userdescpost
    return url_for(userdescpost.user.avatar)
  end
  def created_at
    userdescpost = object.userdescpost
    return userdescpost.created_at
  end
  def share_count
    userdescpost = object.userdescpost
    return userdescpost.userdescpostshares.size
  end
  def user_id
    userdescpost = object.userdescpost
    return userdescpost.user.id
  end
  def comment_count
    userdescpost = object.userdescpost
    return userdescpost.userdescpostcomments.size
  end


end
