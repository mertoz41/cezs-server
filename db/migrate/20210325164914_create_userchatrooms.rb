class CreateUserchatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :userchatrooms do |t|
      t.integer :user_id
      t.integer :chatroom_id

      t.timestamps
    end
  end
end
