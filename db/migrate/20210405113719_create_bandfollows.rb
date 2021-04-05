class CreateBandfollows < ActiveRecord::Migration[6.1]
  def change
    create_table :bandfollows do |t|
      t.integer :band_id
      t.integer :user_id

      t.timestamps
    end
  end
end
