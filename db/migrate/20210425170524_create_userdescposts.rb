class CreateUserdescposts < ActiveRecord::Migration[6.1]
  def change
    create_table :userdescposts do |t|
      t.integer :user_id
      t.string :description
      t.integer :instrument_id

      t.timestamps
    end
  end
end
