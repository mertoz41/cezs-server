class CreateUserdescpostcomments < ActiveRecord::Migration[6.1]
  def change
    create_table :userdescpostcomments do |t|
      t.integer :user_id
      t.integer :userdescpost_id
      t.string :comment

      t.timestamps
    end
  end
end
