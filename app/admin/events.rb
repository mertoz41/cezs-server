ActiveAdmin.register Event do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
index do 
  id_column
  column :address
  column :description
  column "User" do |event|
    if event.user
      link_to event.user.username, admin_user_path(event.user)
    end
  end
  column "Band" do |event|
    if event.band
      link_to event.band.name, admin_band_path(event.band)
    end
  end

  column :latitude
  column :longitude
  column :created_at
  column :event_date
  column :is_audition
  column "Report Count" do |event|
    event.reports.size
  end
end
  # permit_params :address, :description, :user_id, :band_id, :latitude, :longitude, :event_time, :event_date, :is_audition
  #
  # or
  #
  # permit_params do
  #   permitted = [:address, :description, :user_id, :band_id, :latitude, :longitude, :event_time, :event_date, :is_audition]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
