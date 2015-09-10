class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :tmdb_id
      t.string :title
      t.string :backdrop_path
      t.text :overview
      t.string :release_date
      t.string :poster_path
      t.string :imdb_id
      t.integer :runtime
      t.integer :revenue
      t.string :status
      t.text :tagline

      t.timestamps null: false
    end
  end
end
