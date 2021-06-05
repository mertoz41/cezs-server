class CreateUserartists < ActiveRecord::Migration[6.1]
  def change
    create_table :userartists do |t|
      t.integer :user_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
