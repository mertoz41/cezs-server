class CreateNotificationTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_tokens do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
