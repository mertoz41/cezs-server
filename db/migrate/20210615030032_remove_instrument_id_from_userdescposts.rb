class RemoveInstrumentIdFromUserdescposts < ActiveRecord::Migration[6.1]
  def change
    remove_column :userdescposts, :instrument_id, :integer
  end
end
