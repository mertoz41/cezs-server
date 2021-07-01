class CreateUserdescpostviews < ActiveRecord::Migration[6.1]
  def change
    create_table :userdescpostviews do |t|
      t.integer :userdescpost_id
      t.integer :user_id

      t.timestamps
    end
  end
end
