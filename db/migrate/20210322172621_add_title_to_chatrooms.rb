class AddTitleToChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chatrooms, :title, :string
  end
end
