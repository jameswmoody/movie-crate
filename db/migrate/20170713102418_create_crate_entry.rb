class CreateCrateEntry < ActiveRecord::Migration
  def change
    create_table :crate_entries do |t|
      t.integer :movie_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
