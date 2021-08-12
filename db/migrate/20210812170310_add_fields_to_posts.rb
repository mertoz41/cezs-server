class AddFieldsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :band_id, :integer
    add_column :posts, :description, :string
  end
end
