class RemoveBandFromCommentNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :comment_notifications, :band_id, :integer
  end
end
