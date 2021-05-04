class AddThumbnailToUserdescposts < ActiveRecord::Migration[6.1]
  def change
    add_column :userdescposts, :thumbnail, :string
  end
end
