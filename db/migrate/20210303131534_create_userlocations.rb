class CreateUserlocations < ActiveRecord::Migration[6.1]
  def change
    create_table :userlocations do |t|
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
  end
end
