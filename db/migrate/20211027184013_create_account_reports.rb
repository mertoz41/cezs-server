class CreateAccountReports < ActiveRecord::Migration[6.1]
  def change
    create_table :account_reports do |t|
      t.integer :user_id
      t.integer :band_id
      t.integer :action_user_id

      t.timestamps
    end
  end
end
