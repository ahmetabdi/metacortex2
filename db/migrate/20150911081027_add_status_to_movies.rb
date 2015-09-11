class AddStatusToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :state, :string, default: 'generic'
  end
end
