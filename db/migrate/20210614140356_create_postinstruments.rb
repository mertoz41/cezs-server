class CreatePostinstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :postinstruments do |t|
      t.integer :post_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
