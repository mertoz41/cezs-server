class CreateBanddescpostshares < ActiveRecord::Migration[6.1]
  def change
    create_table :banddescpostshares do |t|
      t.integer :banddescpost_id
      t.integer :user_id

      t.timestamps
    end
  end
end
