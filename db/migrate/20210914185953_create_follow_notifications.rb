class CreateFollowNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_notifications do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :action_user_id
      t.integer :band_id
      t.boolean :seen

      t.timestamps
    end
  end
end
