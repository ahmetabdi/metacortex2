class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :rated
      t.datetime :release_date
      t.string :runtime
      t.string :genres
      t.string :director
      t.string :writer
      t.string :actors
      t.string :plot
      t.string :language
      t.string :country
      t.string :awards
      t.string :poster
      t.string :metascore
      t.string :imdb_rating
      t.string :imdb_votes
      t.string :imdb_id

      t.timestamps null: false
    end
  end
end
