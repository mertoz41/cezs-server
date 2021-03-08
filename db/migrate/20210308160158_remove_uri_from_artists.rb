class RemoveUriFromArtists < ActiveRecord::Migration[6.1]
  def change
    remove_column :artists, :uri, :string
  end
end
