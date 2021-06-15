class CreateUserdescpostfeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :userdescpostfeatures do |t|
      t.integer, :user_id
      t.integer :userdescpost_id

      t.timestamps
    end
  end
end
