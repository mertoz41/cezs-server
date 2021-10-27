class CreatePostReports < ActiveRecord::Migration[6.1]
  def change
    create_table :post_reports do |t|
      t.integer :post_id
      t.integer :action_user_id

      t.timestamps
    end
  end
end
