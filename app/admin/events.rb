ActiveAdmin.register Event do

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
end
