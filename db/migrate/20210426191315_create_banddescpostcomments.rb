class CreateBanddescpostcomments < ActiveRecord::Migration[6.1]
  def change
    create_table :banddescpostcomments do |t|
      t.integer :user_id
      t.integer :banddescpost_id
      t.string :comment

      t.timestamps
    end
  end
end
