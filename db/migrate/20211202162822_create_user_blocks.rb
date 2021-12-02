class CreateUserBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_blocks do |t|
      t.integer :blocked_id
      t.integer :blocking_id

      t.timestamps
    end
  end
end
