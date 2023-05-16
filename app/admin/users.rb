ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  index do
    selectable_column
    column :username
    column :email
    column "Location" do |user|
      link_to user.location.city, admin_location_path(user.location)
    end
    column :bio
    column "Posts" do |user|
      user.posts.size
    end
  end

end
