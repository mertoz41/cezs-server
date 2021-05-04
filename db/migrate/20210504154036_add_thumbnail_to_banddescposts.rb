class AddThumbnailToBanddescposts < ActiveRecord::Migration[6.1]
  def change
    add_column :banddescposts, :thumbnail, :string
  end
end
