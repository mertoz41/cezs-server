class RemoveDistrictFromLocations < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :district, :string
  end
end
