class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :address
      t.string :description
      t.integer :user_id
      t.integer :band_id
      t.float :latitude
      t.float :longitude
      t.string :event_time

      t.timestamps
    end
  end
end
