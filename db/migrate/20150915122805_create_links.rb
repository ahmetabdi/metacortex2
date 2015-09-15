class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :link_type, null: false
      t.text :links, array: true, default: []
      t.references :movie, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
