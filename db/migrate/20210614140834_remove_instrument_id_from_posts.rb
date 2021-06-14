class RemoveInstrumentIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :instrument_id, :integer
  end
end
