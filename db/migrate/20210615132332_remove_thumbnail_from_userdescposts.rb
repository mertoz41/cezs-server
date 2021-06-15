class RemoveThumbnailFromUserdescposts < ActiveRecord::Migration[6.1]
  def change
    remove_column :userdescposts, :thumbnail, :string
  end
end
