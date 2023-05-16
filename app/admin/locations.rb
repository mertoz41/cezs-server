ActiveAdmin.register Location do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :latitude, :longitude, :user_id, :city
  #
  # or
  #
index do 

  selectable_column
  column :id
  column "City" do |location|
    link_to location.city, admin_location_path(location)
  end
  column "User Count" do |location|
    location.users.size 
  end
  column "Band Count" do |location|
    location.bands.size
  end



end
end
