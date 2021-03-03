class AddCityStateToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :city, :string
  end
end
