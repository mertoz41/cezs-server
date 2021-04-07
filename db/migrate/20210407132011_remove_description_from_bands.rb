class RemoveDescriptionFromBands < ActiveRecord::Migration[6.1]
  def change
    remove_column :bands, :description, :string
  end
end
