class CreateBanddescpostviews < ActiveRecord::Migration[6.1]
  def change
    create_table :banddescpostviews do |t|
      t.integer :banddescpost_id
      t.integer :user_id

      t.timestamps
    end
  end
end
