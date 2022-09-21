class AddIsauditionToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :is_audition, :boolean
  end
end
