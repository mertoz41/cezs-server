ActiveAdmin.register Band do

  index do
    selectable_column
    column "Name" do |band|
      link_to band.name, admin_band_path(band)
    end
    column "Location" do |band|
      link_to band.location.city, admin_location_path(band.location)
    end
    column :bio
    column :genres
    column "Members" do |band|
    band.members.map(&:username).join(', ')
    end
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
  show do
    attributes_table do
      row :picture do |band|
        image_tag band.picture, :size => "200x200"
      end
      row :name
      row :location do |band|
        link_to band.location.city, admin_location_path(band.location)
      end
      row :bio
      row :genres
      row :created_at
      row :members do |band|
        band.members.map(&:username).join(', ')
      end
      row :events
      row :report_count do |band|
        band.reports.size
      end
      row :post_count do |band|
        band.posts.size
      end
    end
  end
end
