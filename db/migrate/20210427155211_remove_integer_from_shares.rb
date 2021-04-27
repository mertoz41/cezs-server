class RemoveIntegerFromShares < ActiveRecord::Migration[6.1]
  def change
    remove_column :shares, :integer, :string
  end
end
