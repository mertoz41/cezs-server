ActiveAdmin.register User do
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
    column :favoriteartists
    column :favoritesongs

  end

  show do
    attributes_table do
      row :username
      if user.avatar.attached?
        row :avatar do |user|
          image_tag user.avatar, :size => "200x200"
        end
      end
      row :bio
      row :location do |user|
        link_to user.location.city, admin_location_path(user.location)
      end 
      row :email
      row :instruments
      row :genres
      row :favoriteartists
      row :favoritesongs
  
      row :report_count do |user|
        user.reports.size
      end
      row :post_count do |user|
        user.posts.size
      end
   
    end

  end

end
