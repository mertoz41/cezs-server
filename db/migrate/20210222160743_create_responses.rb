class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.integer :request_id
      t.integer :user_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
