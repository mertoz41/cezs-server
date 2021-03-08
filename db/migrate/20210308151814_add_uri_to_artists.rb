class AddUriToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :uri, :string
  end
end
