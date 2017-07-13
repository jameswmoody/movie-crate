class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :poster_url, null: false
      t.string :tagline, null: false
      t.datetime :release_year, null: false
      t.string :overview, null: false
      t.integer :runtime, null: false

      t.timestamps
    end
  end
end
