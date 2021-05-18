class AddGenreToBandposts < ActiveRecord::Migration[6.1]
  def change
    add_column :bandposts, :genre_id, :integer
  end
end
