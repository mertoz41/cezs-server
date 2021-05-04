class AddThumbnailToBandposts < ActiveRecord::Migration[6.1]
  def change
    add_column :bandposts, :thumbnail, :string
  end
end
