class AddGenreToBanddescposts < ActiveRecord::Migration[6.1]
  def change
    add_column :banddescposts, :genre_id, :integer
  end
end
