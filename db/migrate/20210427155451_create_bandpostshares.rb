class CreateBandpostshares < ActiveRecord::Migration[6.1]
  def change
    create_table :bandpostshares do |t|
      t.integer :bandpost_id
      t.integer :user_id

      t.timestamps
    end
  end
end
