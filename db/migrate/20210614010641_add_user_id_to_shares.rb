class AddUserIdToShares < ActiveRecord::Migration[6.1]
  def change
    add_column :shares, :user_id, :integer
  end
end
