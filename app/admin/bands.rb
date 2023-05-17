ActiveAdmin.register Band do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :bio
  #
  # or
  #
index do
  selectable_column
  column "Name" do |band|
    link_to band.name, admin_band_path(band)
  end
  column "Location" do |band|
    link_to band.location.city, admin_location_path(band.location)
  end
  column :bio
  column "Member Count" do |band|
    band.members.size
  end
  column "Post Count" do |band|
    band.posts.size
  end
  column "Event Count" do |band|
    band.events.size
  end
  column "Report Count" do |band|
    band.reports.size
  end
end
  # permit_params do
  #   permitted = [:name, :bio]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
