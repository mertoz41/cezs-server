class AddDistrictToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :district, :string
  end
end
