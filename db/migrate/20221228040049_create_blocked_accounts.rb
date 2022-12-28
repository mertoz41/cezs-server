class CreateBlockedAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :blocked_accounts do |t|
      t.integer :blocked_user_id
      t.integer :blocked_band_id
      t.integer :blocking_user_id

      t.timestamps
    end
  end
end
