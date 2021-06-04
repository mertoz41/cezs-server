class CreateUsersongs < ActiveRecord::Migration[6.1]
  def change
    create_table :usersongs do |t|
      t.integer :user_id
      t.integer :song_id

      t.timestamps
    end
  end
end
