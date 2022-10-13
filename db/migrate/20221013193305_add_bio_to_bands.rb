class AddBioToBands < ActiveRecord::Migration[6.1]
  def change
    add_column :bands, :bio, :string
  end
end
