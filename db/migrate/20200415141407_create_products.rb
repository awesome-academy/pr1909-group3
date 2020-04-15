class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :detail
      t.integer :price
      t.integer :quantity
      t.integer :category_id
      t.string :slug

      t.timestamps
    end
  end
end
