class RemoveThumbnailFromBanddescposts < ActiveRecord::Migration[6.1]
  def change
    remove_column :banddescposts, :thumbnail, :string
  end
end
