class CreateAuditionLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :audition_locations do |t|
      t.integer :audition_id
      t.integer :location_id

      t.timestamps
    end
  end
end
