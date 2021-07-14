class CreateSongfollows < ActiveRecord::Migration[6.1]
  def change
    create_table :songfollows do |t|
      t.integer :song_id
      t.integer :user_id

      t.timestamps
    end
  end
end
