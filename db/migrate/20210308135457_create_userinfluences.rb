class CreateUserinfluences < ActiveRecord::Migration[6.1]
  def change
    create_table :userinfluences do |t|
      t.integer :user_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
