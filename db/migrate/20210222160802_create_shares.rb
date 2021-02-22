class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.integer :post_id
      t.string :user_id
      t.string :integer

      t.timestamps
    end
  end
end
