class CreateMovieRelease < ActiveRecord::Migration
  def change
    create_table :movie_releases do |t|
      t.string :name, null: false
      t.references :movie, index: true, foreign_key: true, null: false
    end
  end
end
