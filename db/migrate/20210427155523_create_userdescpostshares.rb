class CreateUserdescpostshares < ActiveRecord::Migration[6.1]
  def change
    create_table :userdescpostshares do |t|
      t.integer :userdescpost_id
      t.integer :user_id

      t.timestamps
    end
  end
end
