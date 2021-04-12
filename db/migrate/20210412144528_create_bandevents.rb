class CreateBandevents < ActiveRecord::Migration[6.1]
  def change
    create_table :bandevents do |t|
      t.string :address
      t.string :description
      t.integer :band_id
      t.float :latitude
      t.float :longitude
      t.datetime :event_date

      t.timestamps
    end
  end
end
