class CreateApplauds < ActiveRecord::Migration[6.1]
  def change
    create_table :applauds do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
