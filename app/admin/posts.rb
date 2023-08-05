ActiveAdmin.register Post do
 
index do
  id_column

  column "User" do |post|
    if post.user
    link_to post.user.username, admin_user_path(post.user)
    end
  end
  column "Band" do |post|
    if post.band
      link_to post.band.name, admin_band_path(post.band)
    end
  end
  column :genre
  column :artist
  column :song
  column :description
  column "Applaud Count" do |post|
    post.applauds.size
  end
  column "View Count" do |post|
    post.postviews.size
  end
  column "Comment Count" do |post|
    post.comments.size
  end

  column "Report Count" do |post|
    post.reports.size
  end

end

show do
 
  attributes_table do
     if post.user
      row :user do |post|
        link_to post.user.username, admin_user_path(post.user)
      end
  else
    row :band do |post|
      post.band.name
    end
  end
    if post.song
      row :song do |post|
       post.song.name
      end
      row :artist do |post|
        post.artist.name
      end
    end
    row :view_count do |post|
      post.postviews.size
    end
    row :comment_count do |post|
      post.comments.size
    end
    row :applaud_count do |post|
      post.applauds.size
    end
    row :report_count do |post|
      post.reports.size
    end
    row :description do |post|
      post.description
    end

    if post.user
      row :avatar do |post|
        image_tag post.user.avatar, :size => "200x200"
      end
    else
      row :picture do |post|
        image_tag post.band.picture, :size => "200x200"
      end
    end
    row :video do |post|
      video_tag Rails.application.routes.url_helpers.rails_blob_path(post.clip),:controls=>true, :autobuffer=>true,:size => "400x350" rescue nil
end
  end

end

end
