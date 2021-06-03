class RemoveAvatarFromArtists < ActiveRecord::Migration[6.1]
  def change
    remove_column :artists, :avatar, :string
  end
end
