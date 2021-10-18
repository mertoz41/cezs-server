class CreateAuditionNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :audition_notifications do |t|
      t.integer :audition_id
      t.integer :user_id
      t.integer :action_user_id
      t.integer :action_band_id
      t.boolean :seen

      t.timestamps
    end
  end
end
