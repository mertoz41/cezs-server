ActiveAdmin.register Report do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :resolved

index do
  selectable_column
  column :id
  column "Reporting User" do |report|
      link_to report.reporting_user.username, admin_user_path(report.reporting_user)
  end

  column "Report Count" do |report|
    num = 0
    if report.user
      num = report.user.reports.size
    elsif report.post
      num = report.post.reports.size
    elsif report.band
      num = report.band.reports.size
    elsif report.event
      num = report.event.reports.size
    elsif report.comment
      num = report.comment.reports.size
    end
    num
  end
  column :description
  column "User" do |report|
    if report.user
      link_to report.user.username, admin_user_path(report.user)
    else
      if report.post && report.post.user
        link_to report.post.user.username, admin_user_path(report.post.user)
      elsif report.comment
        link_to report.comment.user.username, admin_user_path(report.comment.user)
      elsif report.event && report.event.user
        link_to report.event.user.username, admin_user_path(report.event.user)
      end
    end

  end
  column "Band" do |report|
    if report.band
      link_to report.band.name, admin_band_path(report.band)
    elsif report.event && report.event.band
      link_to report.event.band.name, admin_band_path(report.event.band)
    end

  end
  column "Post" do |report|
    if report.post
      if report.post.song 
        link_to "#{report.post.song.name} - #{report.post.artist.name}", admin_post_path(report.post)
      else
        link_to report.post, admin_post_path(report.post)
      end
    end
  end
  column "Event" do |report|
    if report.event
      link_to report.event.address, admin_event_path(report.event)
    end
  end

  column "Comment" do |report|
    if report.comment
      link_to report.comment.comment, admin_comment_path(report.comment)
    end
  end
  column :resolved
  column :created_at
actions
end
  
end
