class RemoveThumbnailFromBandposts < ActiveRecord::Migration[6.1]
  def change
    remove_column :bandposts, :thumbnail, :string
  end
end
