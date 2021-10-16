class CreateAuditionGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :audition_genres do |t|
      t.integer :audition_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
