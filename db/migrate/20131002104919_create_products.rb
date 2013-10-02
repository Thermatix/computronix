class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.references :category_id, index: true
      t.text :description
      t.decimal :value
      t.integer :stock
      t.string :images

      t.timestamps
    end
  end
end
