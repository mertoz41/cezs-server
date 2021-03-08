class AddAvatarToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :avatar, :string
  end
end
