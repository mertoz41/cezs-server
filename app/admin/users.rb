ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  index do
    selectable_column
    column "Username" do |user|
      link_to user.username, admin_user_path(user)
    end
    column :email
    column "Location" do |user|
      if user.location
        link_to user.location.city, admin_location_path(user.location)
      end
    end
    column :bio
    column "Posts" do |user|
      user.posts.size
    end
  end

end
