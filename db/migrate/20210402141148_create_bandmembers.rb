class CreateBandmembers < ActiveRecord::Migration[6.1]
  def change
    create_table :bandmembers do |t|
      t.integer :member_id
      t.integer :band_id

      t.timestamps
    end
  end
end
