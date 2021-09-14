class CreateShareNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :share_notifications do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :action_user_id

      t.timestamps
    end
  end
end
