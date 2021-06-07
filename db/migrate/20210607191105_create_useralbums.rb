class CreateUseralbums < ActiveRecord::Migration[6.1]
  def change
    create_table :useralbums do |t|
      t.integer :album_id
      t.integer :user_id

      t.timestamps
    end
  end
end
