class IndexModelsOnName < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :username
    add_index :bands, :name
    add_index :songs, :name
    add_index :artists, :name
  end
end
