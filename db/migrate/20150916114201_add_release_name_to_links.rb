class AddReleaseNameToLinks < ActiveRecord::Migration
  def change
    add_column :links, :release_name, :string
  end
end
