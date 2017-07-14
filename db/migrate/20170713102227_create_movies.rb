class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :tmdb_id, null: false

      t.timestamps
    end
  end
end
