class AddSiteToLinks < ActiveRecord::Migration
  def change
    add_column :links, :site, :string
  end
end
