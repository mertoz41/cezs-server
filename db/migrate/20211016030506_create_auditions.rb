class CreateAuditions < ActiveRecord::Migration[6.1]
  def change
    create_table :auditions do |t|
      t.string :description
      t.integer :user_id
      t.integer :band_id
      t.datetime :audition_date

      t.timestamps
    end
  end
end
