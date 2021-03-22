class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :chatroom_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
