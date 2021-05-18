class AddGenreToUserdescposts < ActiveRecord::Migration[6.1]
  def change
    add_column :userdescposts, :genre_id, :integer
  end
end
