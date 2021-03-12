class RemoveIntegerFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :integer, :string
  end
end
