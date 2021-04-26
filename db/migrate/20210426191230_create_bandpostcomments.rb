class CreateBandpostcomments < ActiveRecord::Migration[6.1]
  def change
    create_table :bandpostcomments do |t|
      t.integer :user_id
      t.integer :bandpost_id
      t.string :comment

      t.timestamps
    end
  end
end
