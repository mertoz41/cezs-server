ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :artist_id, :song_id, :genre_id, :band_id, :description
  #
index do
  column :id
  column "User" do |post|
    if post.user
    link_to post.user.username, admin_user_path(post.user)
    end
  end
  column "Band" do |post|
    if post.band
      post.band.name
    end
  end
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

end
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :artist_id, :song_id, :genre_id, :band_id, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
