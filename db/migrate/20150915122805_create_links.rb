class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :link
      t.string :site

      t.timestamps null: false
      t.references :movie, index: true, foreign_key: true, null: false
    end
  end
end
