ActiveAdmin.register Location do

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
