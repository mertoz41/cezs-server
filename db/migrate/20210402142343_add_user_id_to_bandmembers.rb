class AddUserIdToBandmembers < ActiveRecord::Migration[6.1]
  def change
    add_column :bandmembers, :user_id, :integer
  end
end
