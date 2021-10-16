class AddGenreIdToAuditionGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :audition_genres, :genre_id, :integer
  end
end
