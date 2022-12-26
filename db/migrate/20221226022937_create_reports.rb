class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :comment_id
      t.integer :post_id
      t.integer :user_id
      t.integer :band_id
      t.string :description
      t.integer :reporting_user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
