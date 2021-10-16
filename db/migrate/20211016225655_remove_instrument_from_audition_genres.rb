class RemoveInstrumentFromAuditionGenres < ActiveRecord::Migration[6.1]
  def change
    remove_column :audition_genres, :instrument_id, :integer
  end
end
