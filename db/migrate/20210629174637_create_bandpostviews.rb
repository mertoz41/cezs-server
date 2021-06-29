class CreateBandpostviews < ActiveRecord::Migration[6.1]
  def change
    create_table :bandpostviews do |t|
      t.integer :user_id
      t.integer :bandpost_id

      t.timestamps
    end
  end
end
