class RemoveMemberIdFromBandmembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :bandmembers, :member_id, :integer
  end
end
