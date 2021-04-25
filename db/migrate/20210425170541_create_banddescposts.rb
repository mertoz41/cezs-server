class CreateBanddescposts < ActiveRecord::Migration[6.1]
  def change
    create_table :banddescposts do |t|
      t.integer :band_id
      t.string :description

      t.timestamps
    end
  end
end
