class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.boolean :fulfilled
      t.integer :user_id
      t.integer :artist_id
      t.integer :song_id

      t.timestamps
    end
  end
end
