class CreateBandbios < ActiveRecord::Migration[6.1]
  def change
    create_table :bandbios do |t|
      t.string :description
      t.integer :band_id

      t.timestamps
    end
  end
end
