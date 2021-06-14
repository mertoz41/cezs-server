class RemoveUserIdFromShares < ActiveRecord::Migration[6.1]
  def change
    remove_column :shares, :user_id, :string
  end
end
