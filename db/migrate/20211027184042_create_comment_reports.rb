class CreateCommentReports < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_reports do |t|
      t.integer :comment_id
      t.integer :action_user_id

      t.timestamps
    end
  end
end
