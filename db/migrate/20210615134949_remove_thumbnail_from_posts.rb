class RemoveThumbnailFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :thumbnail, :string
  end
end
